# DevSecOps Enterprise Portfolio Project

![GitLab CI](https://img.shields.io/badge/GitLab_CI%2FCD-5.0_Pass-brightgreen?logo=gitlab)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI-blue?logo=githubactions)
![Docker](https://img.shields.io/badge/Docker-24.0-blue?logo=docker)
![Terraform](https://img.shields.io/badge/Terraform-1.5.7-purple?logo=terraform)
![Kubernetes](https://img.shields.io/badge/Kubernetes-Helm_3.14-326CE5?logo=kubernetes)
![Security](https://img.shields.io/badge/Security-Trivy_IaC_%26_CVE-red?logo=aquasec)
![Observability](https://img.shields.io/badge/Observability-Prometheus_Metrics-E6522C?logo=prometheus)

Proyecto integral de automatización DevSecOps para el ciclo de vida de desarrollo seguro, infraestructura como código (IaC), empaquetado en Kubernetes y observabilidad con métricas, manteniendo **paridad y sincronización automatizada entre GitLab CI/CD y GitHub Actions**.

---

## 🛠️ Stack Tecnológico

* **IaC:** Terraform 1.5.7
* **Orquestación & Packaging:** Kubernetes & Helm 3.14
* **CI/CD:** GitLab CI/CD & GitHub Actions (Dual Pipeline Sincronizado)
* **Contenedores & Registros:** Docker & GitLab Container Registry
* **Seguridad & Calidad (DevSecOps):** Trivy (CVE & IaC), ShellCheck, Hadolint, Flake8
* **Observabilidad:** Prometheus (Endpoint `/metrics` en formato OpenMetrics)
* **Scripting & Backend:** Bash & Python (Flask / FastAPI)

---

## 🏗️ Arquitectura del Pipeline y Sistema

```mermaid
graph TD
    A["Developer Push"] --> B["1. Linting Stage"]
    B --> C["2. Build Stage"]
    C --> D["3. Security Stage"]
    D --> E["4. Continuous Deployment"]
    E --> F["5. Observability Stage"]
    E --> G["Kubernetes Cluster"]
    G --> H["Prometheus Metrics"]
```

---

## 🛡️ Matriz de Control DevSecOps

| Etapa | Herramienta | Función / Objetivo |
| :--- | :--- | :--- |
| **Code Linting** | `flake8` | Análisis estático de estándares PEP8 en código Python |
| **Shell Audit** | `shellcheck` | Validación de sintaxis y seguridad en scripts Bash |
| **Dockerfile Security** | `hadolint` | Auditoría de buenas prácticas en imágenes de contenedor |
| **IaC Quality** | `terraform fmt` / `validate` | Verificación declarativa de módulos de Terraform |
| **Helm Linting** | `helm lint` | Validación de sintaxis del paquete Helm |
| **Container CVE Scan** | `Trivy` | Detección de vulnerabilidades de SO y librerías en imágenes |
| **IaC Security Scan** | `Trivy Config` | Escaneo de fallos de seguridad en Terraform y K8s Manifests |
| **Observabilidad** | `Prometheus Client` | Exposición de métricas HTTP (`/metrics`) y estados de salud (`/health`) |

---

## 📁 Estructura del Repositorio

```text
devops-portfolio-project/
├── .github/
│   └── workflows/
│       └── ci.yml               # Pipeline para GitHub Actions
├── .gitlab-ci.yml               # Pipeline para GitLab CI/CD
├── app/
│   ├── Dockerfile               # Construcción de contenedor multi-stage
│   ├── main.py                  # API REST Python con métricas de Prometheus
│   └── requirements.txt         # Dependencias del proyecto (Flask, Prometheus)
├── helm/
│   └── portfolio-api/           # Helm Chart modular para Kubernetes
│       ├── Chart.yaml
│       ├── values.yaml          # Valores base por defecto
│       ├── values-dev.yaml      # Configuración entorno Desarrollo
│       ├── values-prod.yaml     # Configuración entorno Producción
│       └── templates/           # Plantillas Go (Deployment, Service, ConfigMap, _helpers.tpl)
├── k8s/                         # Manifiestos estáticos nativos de Kubernetes
│   ├── configmap.yaml
│   ├── deployment.yaml
│   └── service.yaml
├── scripts/
│   ├── deploy.sh                # Automatización de despliegues locales
│   └── health_check.sh          # Smoke tests de red
├── terraform/                   # Infraestructura como Código (IaC)
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── variables.tf
└── README.md
```

---

## 🚀 Guía de Ejecución Local

### Prerrequisitos
* **Docker Desktop 24+** (con motor Kubernetes activado)
* **Terraform 1.5+**
* **Helm 3.14+**
* **Python 3.11+**

### 1. Ejecutar la API Localmente con Docker
```bash
docker build -t portfolio-api:local ./app
docker run -d -p 8080:8080 portfolio-api:local
```

### 2. Probar Endpoints
```bash
curl http://localhost:8080/
curl http://localhost:8080/health
curl http://localhost:8080/metrics
```

### 3. Aprovisionar Infraestructura con Terraform
```bash
cd terraform
terraform init
terraform apply -var="app_port=8081" -auto-approve
```

### 4. Desplegar en Kubernetes usando Helm
```bash
# Entorno de Desarrollo
helm install api-dev ./helm/portfolio-api/ -f ./helm/portfolio-api/values-dev.yaml

# Entorno de Producción
helm install api-prod ./helm/portfolio-api/ -f ./helm/portfolio-api/values-prod.yaml
```

---

## ✒️ Autor

* **Carlos Nuñez** - DevOps & Systems Engineer