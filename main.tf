terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.50.0"
    }
  }
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}

# Store JIRA API Token in Secret Manager
resource "google_secret_manager_secret" "jira_api_token" {
  secret_id = "jira-api-token"

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "jira_api_token_version" {
  secret_id = google_secret_manager_secret.jira_api_token.id
  secret_data = var.jira_api_token_value
}

# Define the Application Integration Connector for JIRA
resource "google_application_integration_connector" "jira_connector" {
  name        = "jira-connector"
  location    = var.gcp_region
  description = "Connector for JIRA Cloud"
  
  connector_provisioning_config {
    # Configuration specific to the JIRA connector would go here.
    # This is a simplified representation. The actual setup for a 
    # pre-built connector is done via the GCP Console UI.
    # This Terraform resource is more for custom connectors or when
    # the provider supports this level of configuration.
    # For now, we are focusing on managing the credentials.
  }

  # The connection to JIRA requires authentication.
  # We reference the secret we created.
  service_account = var.integration_service_account

  depends_on = [
    google_secret_manager_secret_version.jira_api_token_version,
  ]
}