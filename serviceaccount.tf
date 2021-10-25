resource "google_service_account" "argo_executor" {
  account_id   = "argo-sa"
  project = var.project_id
}

resource "google_project_iam_member" "argo_executor_can_use_storage" {
  project = var.project_id
  role    = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.argo_executor.email}"
}

resource "google_service_account_iam_binding" "gke_argo_sa_act_as_argo_executor" {
  service_account_id = google_service_account.argo_executor.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
   "serviceAccount:${var.project_id}.svc.id.goog[argo/argo]" 
   # "serviceAccount:${google_service_account.helloworld-cr-sa.email}",
  ]
}
