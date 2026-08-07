# End-to-End Cloud DevOps & Infrastructure Pipeline

Este repositorio contiene la arquitectura de infraestructura y el pipeline de CI/CD para desplegar un microservicio observado en Google Cloud Platform (GCP) mediante Terraform, Kubernetes y GitLab CI/CD.

## 🛠️ Stack Tecnológico

* **IaC:** Terraform
* **Orquestación:** Kubernetes (GKE) & Rancher
* **CI/CD:** GitLab CI/CD
* **Contenedores:** Docker
* **Observabilidad:** Grafana + Prometheus
* **Scripting:** Bash

## 📁 Estructura del Proyecto

```text
.
├── app/          # Código fuente de la aplicación y Dockerfile
├── terraform/    # Módulos de infraestructura como código (GCP)
├── k8s/          # Manifestos y Helm Charts para Kubernetes
├── scripts/      # Scripts en Bash para automatización local
└── .gitlab-ci.yml # Definición del pipeline de CI/CD