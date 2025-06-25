# OtoBlog

🚀 **OtoBlog**, Hugo ile yazılmış statik blog sayfalarını GitHub Actions üzerinden otomatik olarak Minikube üzerine yayınlayan bir CI/CD projesidir.

## 🎯 Proje Amacı

Bu proje, yazılım geliştiricilere şu konularda uygulamalı deneyim kazandırmak için hazırlanmıştır:

- CI/CD süreci nedir ve nasıl işler?
- Statik site oluşturucu olarak Hugo nasıl kullanılır?
- Docker ile imaj oluşturma ve yayınlama
- Minikube kullanarak yerel Kubernetes dağıtımı

## 🛠️ Kullanılan Teknolojiler

- [Hugo](https://gohugo.io/)
- Docker
- GitHub Actions
- Minikube
- Kubernetes (kubectl)

## 🚧 Kurulum ve Kullanım

### 1. Hugo Projesi Oluştur

```bash
hugo new site otoblog
cd otoblog
git init
```

Bir tema ekle:

```bash
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo 'theme = "ananke"' >> config.toml
```

### 2. Blog Yazısı Ekle

```bash
hugo new posts/ilk-yazi.md
```

`content/posts/ilk-yazi.md` dosyasını düzenle ve yayına hazırla.

### 3. Commit ve Push Et

```bash
git add .
git commit -m "İlk blog gönderisi"
git push origin main
```

### 4. GitHub Actions ne yapacak?

- Hugo ile siteyi derler
- Docker imajını oluşturur ve GitHub Container Registry'e gönderir
- Minikube üzerinde `otoblog` adında bir deployment başlatır
- Servisi dışa açar ve bağlantı adresini verir

## 🌐 Servise Erişim

```bash
minikube service otoblog --url
```

---

## 🧪 Notlar

- `Dockerfile` Hugo ile build eder, `nginx` ile sunar.
- `deploy.yml` sadece `main` dalındaki push’larda çalışır.
- Minikube kurulu olmalıdır. [Kurulum rehberi](https://minikube.sigs.k8s.io/docs/start/)

## 📄 Lisans

Bu proje MIT lisansı ile lisanslanmıştır.
