output "aws_s3_website_url" {
  description = "AWS S3 static website endpoint"
  value       = "http://${aws_s3_bucket_website_configuration.primary.website_endpoint}"
}

output "azure_blob_website_url" {
  description = "Azure Blob static website endpoint"
  value       = azurerm_storage_account.dr.primary_web_endpoint
}

output "route53_domain" {
  description = "Your custom domain"
  value       = "http://www.${var.domain_name}"
}

output "health_check_id" {
  description = "Route 53 health check ID"
  value       = aws_route53_health_check.primary.id
}