#!/bin/bash

# OtoBlog Setup Script
echo "🚀 OtoBlog kurulum scripti başlatılıyor..."

# Check if Hugo is installed
if ! command -v hugo &> /dev/null; then
    echo "❌ Hugo bulunamadı. Lütfen Hugo'yu kurun: https://gohugo.io/installation/"
    exit 1
fi

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker bulunamadı. Lütfen Docker'ı kurun: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if kubectl is installed
if ! command -v kubectl &> /dev/null; then
    echo "❌ kubectl bulunamadı. Lütfen kubectl'i kurun: https://kubernetes.io/docs/tasks/tools/"
    exit 1
fi

# Check if minikube is installed
if ! command -v minikube &> /dev/null; then
    echo "❌ Minikube bulunamadı. Lütfen Minikube'yi kurun: https://minikube.sigs.k8s.io/docs/start/"
    exit 1
fi

echo "✅ Gerekli araçlar kontrol edildi."

# Create necessary directories if they don't exist
mkdir -p content/posts
mkdir -p layouts/_default
mkdir -p layouts/posts
mkdir -p assets/css
mkdir -p assets/js
mkdir -p static
mkdir -p k8s
mkdir -p .github/workflows
mkdir -p scripts

echo "✅ Dizinler oluşturuldu."

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git repository başlatıldı."
fi

# Add theme as submodule if not exists
if [ ! -d "themes/ananke" ]; then
    git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
    echo "✅ Ananke teması eklendi."
fi

# Build the site
echo "🔨 Hugo site build ediliyor..."
hugo --minify

if [ $? -eq 0 ]; then
    echo "✅ Site başarıyla build edildi."
else
    echo "❌ Site build edilirken hata oluştu."
    exit 1
fi

# Start minikube if not running
if ! minikube status | grep -q "Running"; then
    echo "🚀 Minikube başlatılıyor..."
    minikube start --driver=docker
    echo "✅ Minikube başlatıldı."
else
    echo "✅ Minikube zaten çalışıyor."
fi

echo ""
echo "🎉 Kurulum tamamlandı!"
echo ""
echo "Kullanılabilir komutlar:"
echo "  make serve     - Geliştirme sunucusunu başlat"
echo "  make build     - Siteyi build et"
echo "  make docker-build - Docker imajını oluştur"
echo "  make k8s-deploy    - Kubernetes'e deploy et"
echo ""
echo "Siteyi görüntülemek için: http://localhost:1313"
echo "Minikube servis URL'si için: make k8s-url" 