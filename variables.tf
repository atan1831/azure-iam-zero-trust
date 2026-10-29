variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "prefix" {
  description = "Prefix for all resources"
  type        = string
  default     = "sec"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}