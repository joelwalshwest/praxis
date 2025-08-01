variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "mlstudio-440903"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-east1"
}

variable "cloudsql_instance" {
  description = "Cloud SQL connection string"
  type        = string
  default     = "mlstudio-440903:us-east4:mlstudio-db"
}
