variable "gcp_project_id" {
  description = "The GCP project ID to deploy the resources in."
  type        = string
}

variable "gcp_region" {
  description = "The GCP region for the resources."
  type        = string
  default     = "us-central1"
}

variable "jira_api_token_value" {
  description = "The API token for JIRA authentication."
  type        = string
  sensitive   = true
}

variable "integration_service_account" {
  description = "The service account email for the Application Integration."
  type        = string
}