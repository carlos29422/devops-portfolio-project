# ==============================================================================
# Configuración de Proveedores y Versiones de Terraform
# ==============================================================================

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine" # Conexión nativa con Docker Desktop en Windows
}