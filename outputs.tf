output "base_url" {
  description = "Base URL for API Gateway stage."
  value       = module.api_gateway.api_endpoint
}
