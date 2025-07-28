# استخدم إصدارًا أقدم من Ubuntu لضمان التوافق مع AVISPA
FROM ubuntu:20.04

# تجنب طلب الإدخال أثناء التثبيت
ENV DEBIAN_FRONTEND=noninteractive

# تثبيت الحزم الأساسية اللازمة لتشغيل AVISPA (وهي أداة 32-bit)
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    tar \
    gzip \
    libc6:i386 \
    libstdc++6:i386 \
    && rm -rf /var/lib/apt/lists/*

# تنزيل وتثبيت أداة AVISPA
# ملاحظة: هذا هو آخر رابط عام معروف للأداة
RUN wget http://www.avispa-project.org/download/avispa-tool-1.1.tar.gz && \
    tar -xzf avispa-tool-1.1.tar.gz && \
    cd avispa-tool-1.1 && \
    ./install.sh

# إضافة مسار أداة AVISPA إلى متغيرات البيئة لتسهيل الوصول إليها
ENV PATH="/avispa-tool-1.1/bin:${PATH}"
