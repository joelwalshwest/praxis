resource "google_cloud_run_v2_service" "prod_praxis_server" {
  name     = "prod-praxis-server"
  location = var.region
  deletion_protection=false

  template {
    service_account = google_service_account.prod_praxis_server.email
    containers {
      name  = "prod-praxis-server-1"
      image = "joelwalshwest/prod-praxis-server:latest"

      ports {
        container_port = 8080
      }

      env {
        name  = "ENVIRONMENT"
        value = "prod"
      }

      env {
        name = "MYSQL_USERNAME"
        value_source {
          secret_key_ref {
            secret = "mysql-prod-username"
            version = "latest"
          }
        }
      }

      env {
        name = "MYSQL_PASSWORD"
        value_source {
          secret_key_ref {
            secret = "mysql-prod-password"
            version = "latest"
          }
        }
      }

      env {
        name = "OPENAI_API_KEY"
        value_source {
          secret_key_ref {
            secret = "OPENAI_API_KEY"
            version = "latest"
          }
        }
      }

      resources {
        limits = {
          cpu    = "1000m"
          memory = "512Mi"
        }
      }

      startup_probe {
        tcp_socket {
          port = 8080
        }
        period_seconds    = 240
        timeout_seconds   = 240
        failure_threshold = 1
      }
    }

    timeout                 = "300s"

    annotations = {
      "autoscaling.knative.dev/maxScale"      = "100"
      "run.googleapis.com/startup-cpu-boost"  = "true"
      "run.googleapis.com/cloudsql-instances" = var.cloudsql_instance
    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"
}

resource "google_cloud_run_v2_service" "qa_praxis_server" {
  name     = "qa-praxis-server"
  location = var.region
  deletion_protection=false

  template {
    service_account = google_service_account.qa_praxis_server.email
    containers {
      name  = "qa-praxis-server-1"
      image = "joelwalshwest/qa-praxis-server:latest"

      ports {
        container_port = 8080
      }

      env {
        name  = "ENVIRONMENT"
        value = "qa"
      }

      env {
        name = "MYSQL_USERNAME"
        value_source {
          secret_key_ref {
            secret = "mysql-qa-username"
            version = "latest"
          }
        }
      }

      env {
        name = "MYSQL_PASSWORD"
        value_source {
          secret_key_ref {
            secret = "mysql-qa-password"
            version = "latest"
          }
        }
      }

      env {
        name = "OPENAI_API_KEY"
        value_source {
          secret_key_ref {
            secret = "OPENAI_API_KEY"
            version = "latest"
          }
        }
      }

      resources {
        limits = {
          cpu    = "1000m"
          memory = "512Mi"
        }
      }

      startup_probe {
        tcp_socket {
          port = 8080
        }
        period_seconds    = 240
        timeout_seconds   = 240
        failure_threshold = 1
      }
    }

    timeout                 = "300s"

    annotations = {
      "autoscaling.knative.dev/maxScale"      = "100"
      "run.googleapis.com/startup-cpu-boost"  = "true"
      "run.googleapis.com/cloudsql-instances" = var.cloudsql_instance
    }
  }

  ingress = "INGRESS_TRAFFIC_ALL"
}
