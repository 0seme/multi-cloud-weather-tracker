variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "aws_bucket_name" {
  type        = string
  description = "Globally unique S3 bucket name for primary site"
}

variable "azure_resource_group_name" {
  type        = string
  description = "Name of the Azure resource group"
}

variable "azure_storage_account_name" {
  type        = string
  description = "Globally unique Azure storage account name - lowercase, no hyphens, max 24 chars"
}

variable "azure_location" {
  type        = string
  description = "Azure region for resources"
  default     = "East US"
}

variable "domain_name" {
  type        = string
  description = "Your Route 53 domain name e.g. koko-devops.website"
}

variable "weather_api_key" {
  type        = string
  description = "OpenWeatherMap API key"
  sensitive   = true
}