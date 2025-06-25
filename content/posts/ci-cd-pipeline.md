---
title: "CI/CD Pipeline ile Otomatik Deployment"
date: 2024-01-03T16:00:00+03:00
draft: false
description: "GitHub Actions kullanarak otomatik CI/CD pipeline nasıl kurulur?"
tags: ["ci-cd", "github-actions", "docker", "kubernetes"]
categories: ["devops"]
---

# CI/CD Pipeline ile Otomatik Deployment

Modern yazılım geliştirme süreçlerinde CI/CD (Continuous Integration/Continuous Deployment) pipeline'ları vazgeçilmez hale gelmiştir. Bu yazıda GitHub Actions kullanarak nasıl otomatik bir deployment pipeline'ı kurulacağını öğreneceğiz.

## CI/CD Nedir?

### Continuous Integration (CI)
- Kod değişikliklerinin sürekli olarak ana branch'e entegre edilmesi
- Otomatik test çalıştırma
- Kod kalitesi kontrolleri

### Continuous Deployment (CD)
- Test edilen kodun otomatik olarak production ortamına deploy edilmesi
- Manuel müdahale gerektirmeyen süreç

## GitHub Actions Workflow

OtoBlog projemizde kullandığımız workflow şu adımları içerir:

```yaml
name: Deploy to Minikube

on:
  push:
    branches: [ main ]

jobs:
  build-and-deploy:
    runs-on: ubuntu-latest
    
    steps:
    - name: Checkout code
      uses: actions/checkout@v3
      
    - name: Build and push Docker image
      uses: docker/build-push-action@v4
      with:
        context: .
        push: true
        tags: ghcr.io/${{ github.repository }}:latest
        
    - name: Deploy to Minikube
      run: |
        kubectl apply -f k8s/deployment.yml
        kubectl apply -f k8s/service.yml
```

## Docker Build Süreci

### Multi-stage Build

```dockerfile
# Build stage
FROM klakegg/hugo:ext-alpine AS builder
WORKDIR /src
COPY . .
RUN hugo --minify

# Production stage
FROM nginx:alpine
COPY --from=builder /src/public /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

Bu yaklaşımın avantajları:
- Daha küçük production imajı
- Build araçları production'da bulunmaz
- Güvenlik açısından daha iyi

## Kubernetes Deployment

### Deployment YAML

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: otoblog
spec:
  replicas: 2
  selector:
    matchLabels:
      app: otoblog
  template:
    spec:
      containers:
      - name: otoblog
        image: ghcr.io/username/otoblog:latest
        ports:
        - containerPort: 80
```

### Service YAML

```yaml
apiVersion: v1
kind: Service
metadata:
  name: otoblog
spec:
  type: NodePort
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30080
  selector:
    app: otoblog
```

## Avantajlar

### 1. Otomasyon
- Manuel deployment hatalarını önler
- Tutarlı deployment süreçleri
- Zaman tasarrufu

### 2. Güvenlik
- Container Registry kullanımı
- Image scanning
- Rollback imkanı

### 3. Ölçeklenebilirlik
- Kubernetes ile kolay ölçeklendirme
- Load balancing
- High availability

## Monitoring ve Logging

Deployment sonrası monitoring için:

```bash
# Pod durumunu kontrol et
kubectl get pods -l app=otoblog

# Logları görüntüle
kubectl logs -l app=otoblog

# Service URL'sini al
minikube service otoblog --url
```

## Best Practices

1. **Environment Variables**: Hassas bilgileri environment variable olarak sakla
2. **Resource Limits**: Container'lara memory ve CPU limitleri koy
3. **Health Checks**: Liveness ve readiness probe'ları kullan
4. **Rolling Updates**: Zero-downtime deployment için rolling update stratejisi
5. **Backup**: Veritabanı ve konfigürasyon yedekleri al

## Sonuç

CI/CD pipeline'ları modern yazılım geliştirme süreçlerinin temel taşlarıdır. GitHub Actions, Docker ve Kubernetes kombinasyonu ile güçlü ve güvenilir deployment süreçleri oluşturabiliriz.

OtoBlog projemiz bu yaklaşımın pratik bir örneğidir. Her push işleminde otomatik olarak build, test ve deployment süreçleri çalışır.

---

*Bu yazı CI/CD pipeline'larının temellerini kapsamaktadır. Daha detaylı bilgi için [GitHub Actions](https://docs.github.com/en/actions) ve [Kubernetes](https://kubernetes.io/docs/) dokümantasyonlarını inceleyebilirsiniz.* 