# ==============================================================================
# Variables de Entrada para el Entorno
# ==============================================================================

variable "environment" {
  type        = string
  description = "Entorno de despliegue (dev, staging, prod)"
  default     = "dev"
}

variable "app_port" {
  type        = number
  description = "Puerto expuesto por el contenedor"
  default     = 8081
}

variable "container_name_prefix" {
  type        = string
  description = "Prefijo para los nombres de contenedores gestionados"
  default     = "portfolio-api"
}