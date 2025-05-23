# QuizMaster Docker Kurulumu

Bu dokümantasyon, QuizMaster uygulamasını Docker ile tek konteyner içinde çalıştırmak için gerekli adımları açıklar.

## Gereksinimler

- Docker (Docker Compose plugin ile birlikte)

## Kurulum

### 1. Docker'ı yükleyin

**Ubuntu/Debian için:**
```bash
sudo apt update
sudo apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
```

**CentOS/RHEL/Fedora için:**
```bash
sudo dnf install docker
sudo systemctl start docker
sudo systemctl enable docker
```

**macOS için:**
```bash
# Homebrew ile
brew install --cask docker

# Veya Docker Desktop'u manuel olarak indirin:
# https://www.docker.com/products/docker-desktop
```

### 2. Kullanıcıyı Docker grubuna ekleyin (sadece Linux)

```bash
sudo usermod -aG docker $USER
```
Bu değişikliğin etkili olması için çıkış yapıp tekrar giriş yapın.

**Not:** macOS'ta Docker Desktop kullanıyorsanız bu adım gerekli değildir.

### 3. Projeyi klonlayın (eğer henüz yapmadıysanız)

```bash
git clone <repository-url>
cd QuizMaster
```

## Uygulamayı Çalıştırma

### Otomatik başlatma (Önerilen):

```bash
./start.sh
```

Bu script hem Linux hem macOS'ta çalışır ve otomatik olarak:
- İşletim sistemini tespit eder
- Docker kurulum durumunu kontrol eder
- Gerekli servisleri başlatır
- Uygulamayı build edip çalıştırır

### Manuel başlatma:

**Tek komutla çalıştırma:**

```bash
docker compose up --build
```

**Arka planda çalıştırma:**

```bash
docker compose up --build -d
```

**Logları görüntüleme:**

```bash
docker compose logs -f
```

## Erişim

Uygulama çalıştıktan sonra tarayıcınızda şu adresi açın:

**http://localhost:5000**

## Durdurma ve Temizlik

### Uygulamayı durdurma:

```bash
docker compose down
```

### Verileri de silmek için:

```bash
docker compose down -v
```

### Tüm Docker kaynaklarını temizleme:

```bash
docker system prune -a
```

## macOS'a Özel Notlar

### Docker Desktop Gereksinimleri
- macOS 10.15 veya daha yeni
- 4 GB RAM (8 GB önerilir)
- VirtualBox çalışmıyorsa

### Docker Desktop Başlatma
macOS'ta Docker Desktop otomatik başlatılmaya çalışır, ancak manuel başlatmanız gerekirse:

```bash
open -a Docker
```

### Performans İpuçları
- Docker Desktop'ta Resources > Advanced bölümünden CPU ve RAM ayarlarını optimize edin
- "Use gRPC FUSE for file sharing" seçeneğini etkinleştirin (daha iyi performans için)

### M1/M2 Mac Notları
Apple Silicon (M1/M2) Mac'lerde çalışırken herhangi bir ek ayar gerekmez. Docker Desktop otomatik olarak ARM64 konteynerlerini kullanır.

## Yapılandırma

### Environment Variables

`docker-compose.yml` dosyasında aşağıdaki ayarları güncelleyebilirsiniz:

- `JWT_SECRET`: JWT güvenlik anahtarı
- `EMAIL_USER`: E-posta bildirimler için e-posta adresi
- `EMAIL_PASSWORD`: E-posta şifresi
- `MONGO_INITDB_ROOT_USERNAME`: MongoDB root kullanıcı adı
- `MONGO_INITDB_ROOT_PASSWORD`: MongoDB root şifresi

### Portlar

- **5000**: Ana uygulama portu (Frontend + Backend)
- **27017**: MongoDB portu (sadece geliştirme için)

## Sorun Giderme

### 1. Port zaten kullanılıyor hatası

**Linux:**
```bash
# Portları kontrol edin
sudo netstat -tulpn | grep :5000

# Docker konteynerlerini kontrol edin
docker ps -a

# Çakışan konteynerleri durdurun
docker stop <container-id>
```

**macOS:**
```bash
# Portları kontrol edin
lsof -i :5000

# Docker konteynerlerini kontrol edin
docker ps -a

# Çakışan konteynerleri durdurun
docker stop <container-id>
```

### 2. Build hatası

```bash
# Docker cache'i temizleyin
docker builder prune

# Yeniden build edin
docker compose build --no-cache
```

### 3. MongoDB bağlantı problemi

```bash
# MongoDB konteynerinin çalıştığını kontrol edin
docker compose ps

# MongoDB loglarını kontrol edin
docker compose logs mongodb
```

### 4. macOS'ta Docker Desktop başlamıyor

```bash
# Docker Desktop'u yeniden başlatın
killall Docker && open -a Docker

# Veya tamamen yeniden yükleyin
brew uninstall --cask docker
brew install --cask docker
```

### 5. Frontend dosyaları yüklenmiyorsa

React build dosyalarının doğru şekilde kopyalandığını kontrol edin:

```bash
# App konteynerine bağlanın
docker exec -it quizmaster-app sh

# Public klasörünü kontrol edin
ls -la /app/public/
```

## Geliştirme Modu

Geliştirme sırasında değişiklikleri hızlıca test etmek için:

```bash
# Sadece uygulamayı yeniden build edin
docker compose build quizmaster-app

# Yeniden başlatın
docker compose up quizmaster-app
```

## Performans Optimizasyonu

### 1. Node.js memory limitini artırın (gerekirse)

```yaml
# docker-compose.yml'de
environment:
  - NODE_OPTIONS=--max-old-space-size=2048
```

### 2. Build cache kullanın

```bash
# Build cache'i koruyarak build edin
docker compose build --parallel
```

### 3. macOS'ta dosya paylaşımı optimizasyonu

Docker Desktop > Preferences > Resources > File Sharing bölümünde sadece gerekli klasörleri paylaştığınızdan emin olun.

## Güvenlik Notları

1. **Üretim ortamında** `JWT_SECRET` değerini mutlaka değiştirin
2. **MongoDB şifrelerini** güçlü şifreler ile değiştirin
3. **Email bilgilerini** gerçek bilgilerinizle güncelleyin
4. **Portları** gerekirse değiştirin (80, 443 gibi)

## Docker Volume Yedekleme

MongoDB verilerini yedeklemek için:

```bash
# Veritabanını dışa aktarın
docker exec quizmaster-mongo mongodump --db quizmaster --out /backup

# Volume'u yedekleyin
docker run --rm -v quizmaster_mongodb_data:/data -v $(pwd):/backup alpine tar czf /backup/mongodb-backup.tar.gz -C /data .
```

## Destek

Sorunlarla karşılaştığınızda:

1. Bu dokümantasyondaki sorun giderme bölümünü kontrol edin
2. Docker loglarını inceleyin: `docker compose logs`
3. İşletim sisteminize özel bölümleri kontrol edin
4. GitHub Issues'da yeni bir issue açın 