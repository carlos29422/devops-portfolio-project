# ==============================================================================
# Recurso Principal: Descarga e Instanciación del Contenedor mediante IaC
# ==============================================================================

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# Obtener la imagen compilada previamente
resource "docker_image" "api_image" {
  name         = "devops-portfolio-api:1.0.0"
  keep_locally = true
}

# Desplegar el contenedor de forma declarativa
resource "docker_container" "api_container" {
  name  = "${var.container_name_prefix}-${var.environment}-${random_string.suffix.result}"
  image = docker_image.api_image.image_id

  ports {
    internal = 8080
    external = var.app_port
  }

  env = [
    "ENVIRONMENT=${var.environment}",
    "PORT=8080"
  ]

  restart = "unless-stopped"
}