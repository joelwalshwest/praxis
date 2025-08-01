resource "google_service_account" "prod_praxis_server" {
  account_id   = "prod-praxis-server"
  display_name = "Service Account for prod-praxis-server"
  description  = "Used by the prod-praxis-server Cloud Run service"
}

resource "google_project_iam_member" "prod_cloudsql_access" {
  role   = "roles/cloudsql.client"
  member = "serviceAccount:${google_service_account.prod_praxis_server.email}"
  project = var.project_id
}

resource "google_project_iam_member" "prod_secretmanager_access" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.prod_praxis_server.email}"
  project = var.project_id
}

resource "google_project_iam_member" "prod_run_invoker" {
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.prod_praxis_server.email}"
  project = var.project_id
}

resource "google_service_account" "qa_praxis_server" {
  account_id   = "qa-praxis-server"
  display_name = "Service Account for qa-praxis-server"
  description  = "Used by the qa-praxis-server Cloud Run service"
}

resource "google_project_iam_member" "qa_cloudsql_access" {
  role   = "roles/cloudsql.client"
  member = "serviceAccount:${google_service_account.qa_praxis_server.email}"
  project = var.project_id
}

resource "google_project_iam_member" "qa_secretmanager_access" {
  role   = "roles/secretmanager.secretAccessor"
  member = "serviceAccount:${google_service_account.qa_praxis_server.email}"
  project = var.project_id
}

resource "google_project_iam_member" "qa_run_invoker" {
  role   = "roles/run.invoker"
  member = "serviceAccount:${google_service_account.qa_praxis_server.email}"
  project = var.project_id
}
