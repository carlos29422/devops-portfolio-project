# ==============================================================================
# Salidas de Infraestructura
# ==============================================================================

output "container_id" {
  value       = docker_container.api_container.id
  description = "ID del contenedor desplegado por Terraform"
}

output "container_name" {
  value       = docker_container.api_container.name
  description = "Nombre asignado al contenedor"
}

output "service_url" {
  value       = "http://localhost:${var.app_port}"
  description = "URL local de acceso al servicio aprovisionado"
}