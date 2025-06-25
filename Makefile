.PHONY: help build serve clean docker-build docker-run k8s-deploy k8s-delete

# Default target
help:
	@echo "Available commands:"
	@echo "  build        - Build the Hugo site"
	@echo "  serve        - Start Hugo development server"
	@echo "  clean        - Clean build artifacts"
	@echo "  docker-build - Build Docker image"
	@echo "  docker-run   - Run Docker container locally"
	@echo "  k8s-deploy   - Deploy to Kubernetes"
	@echo "  k8s-delete   - Delete Kubernetes deployment"

# Build the Hugo site
build:
	hugo --minify

# Start Hugo development server
serve:
	hugo server --bind 0.0.0.0 --port 1313

# Clean build artifacts
clean:
	rm -rf public/
	rm -f .hugo_build.lock

# Build Docker image
docker-build:
	docker build -t otoblog:latest .

# Run Docker container locally
docker-run:
	docker run -p 8080:80 otoblog:latest

# Deploy to Kubernetes
k8s-deploy:
	kubectl apply -f k8s/deployment.yml
	kubectl apply -f k8s/service.yml
	kubectl get pods -l app=otoblog

# Delete Kubernetes deployment
k8s-delete:
	kubectl delete -f k8s/service.yml
	kubectl delete -f k8s/deployment.yml

# Get service URL
k8s-url:
	minikube service otoblog --url

# Check deployment status
k8s-status:
	kubectl get pods -l app=otoblog
	kubectl get services -l app=otoblog 