#!/bin/bash

# QuizMaster Docker Başlatma Script'i
# Bu script QuizMaster uygulamasını Docker ile başlatır
# Linux ve macOS uyumlu

echo "🚀 QuizMaster Docker Setup Başlatılıyor..."
echo "======================================="

# İşletim sistemi tespiti
OS="$(uname -s)"
case "${OS}" in
    Linux*)     MACHINE=Linux;;
    Darwin*)    MACHINE=Mac;;
    CYGWIN*)    MACHINE=Cygwin;;
    MINGW*)     MACHINE=MinGw;;
    *)          MACHINE="UNKNOWN:${OS}"
esac

echo "🖥️  İşletim Sistemi: ${MACHINE}"

# Docker'ın kurulu olup olmadığını kontrol et
if ! command -v docker &> /dev/null; then
    echo "❌ Docker bulunamadı. Lütfen Docker'ı yükleyin."
    case "${MACHINE}" in
        Linux)
            echo "Ubuntu/Debian: sudo apt install docker.io"
            echo "CentOS/RHEL/Fedora: sudo dnf install docker"
            ;;
        Mac)
            echo "macOS: Docker Desktop'u indirin: https://www.docker.com/products/docker-desktop"
            echo "Homebrew ile: brew install --cask docker"
            ;;
    esac
    exit 1
fi

# Docker Compose plugin'inin kurulu olup olmadığını kontrol et
if ! docker compose version &> /dev/null; then
    echo "❌ Docker Compose plugin bulunamadı. Lütfen Docker Compose'u yükleyin."
    echo "Modern Docker kurulumları ile birlikte gelir."
    exit 1
fi

# Docker servisinin çalışıp çalışmadığını kontrol et
echo "🔧 Docker servisi kontrol ediliyor..."
case "${MACHINE}" in
    Linux)
        if ! sudo systemctl is-active --quiet docker; then
            echo "🔧 Docker servisi başlatılıyor..."
            sudo systemctl start docker
        fi
        ;;
    Mac)
        if ! docker info &> /dev/null; then
            echo "🔧 Docker Desktop başlatılıyor..."
            echo "⚠️  Docker Desktop'u manuel olarak başlatmanız gerekebilir."
            open -a Docker
            echo "⏳ Docker Desktop'un başlaması bekleniyor (30 saniye)..."
            sleep 30
        fi
        ;;
esac

# Eski konteynerleri durdur ve temizle (varsa)
echo "🧹 Eski konteynerleri temizleniyor..."
docker compose down 2>/dev/null

# Port 5001'in boş olup olmadığını kontrol et
echo "🔌 Port 5001 kontrol ediliyor..."
if command -v lsof &> /dev/null; then
    if lsof -i:5001 &>/dev/null; then
        echo "⚠️  Port 5001 kullanılıyor. Başka bir uygulamayı kapatmanız gerekebilir."
        read -p "Devam etmek istiyor musunuz? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
else
    echo "ℹ️  lsof komutu bulunamadı, port kontrolü atlanıyor."
fi

# Docker build ve çalıştırma
echo "🏗️  Docker image'ları build ediliyor..."
docker compose build

if [ $? -eq 0 ]; then
    echo "✅ Build başarılı!"
    echo "🚀 Uygulamalar başlatılıyor..."
    
    # Arka planda çalıştır
    docker compose up -d
    
    if [ $? -eq 0 ]; then
        echo ""
        echo "🎉 QuizMaster başarıyla başlatıldı!"
        echo "======================================="
        echo "📱 Uygulama: http://localhost:5001"
        echo "🗄️  MongoDB: localhost:27017"
        echo ""
        echo "📋 Yararlı komutlar:"
        echo "   Logları görmek için: docker compose logs -f"
        echo "   Durdurmak için: docker compose down"
        echo "   Yeniden başlatmak için: docker compose restart"
        echo ""
        echo "⏳ Konteynerler başlatılıyor... (30-60 saniye bekleyin)"
        
        # 30 saniye bekleyip durumu kontrol et
        sleep 30
        
        echo "🔍 Konteyner durumları kontrol ediliyor..."
        docker compose ps
        
        # Sağlık kontrolü
        echo "🏥 Sağlık kontrolü yapılıyor..."
        if command -v curl &> /dev/null; then
            if curl -f http://localhost:5001 &>/dev/null; then
                echo "✅ Uygulama başarıyla çalışıyor!"
                echo "🌐 Tarayıcınızda http://localhost:5001 adresini açın"
            else
                echo "⚠️  Uygulama henüz tam olarak başlamadı. Birkaç dakika daha bekleyin."
                echo "📋 Logları kontrol etmek için: docker compose logs -f"
            fi
        else
            echo "ℹ️  curl komutu bulunamadı, sağlık kontrolü atlanıyor."
            echo "🌐 Tarayıcınızda http://localhost:5001 adresini açın"
        fi
        
    else
        echo "❌ Uygulama başlatılamadı. Logları kontrol edin:"
        echo "docker compose logs"
        exit 1
    fi
else
    echo "❌ Build başarısız. Hataları kontrol edin."
    exit 1
fi 