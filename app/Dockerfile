FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV FLUTTER_HOME=/flutter
ENV PATH="${FLUTTER_HOME}/bin:${PATH}"

# ビルド依存パッケージ
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git unzip xz-utils zip ca-certificates \
    cmake ninja-build clang pkg-config \
    libgtk-3-dev libblkid-dev liblzma-dev \
    libglib2.0-dev libpango1.0-dev libcairo2-dev \
    libgdk-pixbuf2.0-dev libegl1-mesa-dev libgl1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# Flutter SDK インストール（stable）
RUN git clone --depth 1 --branch stable https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Flutter の初期設定
RUN flutter config --no-analytics \
    && flutter config --enable-linux-desktop \
    && flutter precache --linux

WORKDIR /app

# pubspec をコピーして依存関係を先にキャッシュ
COPY pubspec.yaml pubspec.lock ./
RUN flutter pub get

# ソース全体をコピー
COPY . .

# Linux リリースビルド
RUN flutter build linux --release

CMD ["bash"]
