# Linhas para criar a instância e banco de dados no Cloud SQL da Google Cloud

resource "google_sql_database_instance" "instance" {
  name   = "luxxy-covid-testing-system-database-instance-pt"
  region = var.gcp_region
  database_version = "MYSQL_5_7"
  settings {
    tier = "db-f1-micro"
  }

  deletion_protection  = "true"
}

resource "google_sql_database" "database" {
  name              = "dbcovidtesting"
  instance          = google_sql_database_instance.instance.name
}

# Linhas para criar o Google Kubernetes Engine (GKE)

resource "google_container_cluster" "primary" {
  name               = "luxxy-kubernetes-cluster-pt"
  location           = var.gcp_region
  initial_node_count = 1
  ip_allocation_policy {
  }
  enable_autopilot = true
  node_config {
  
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    labels = {
      environment = "training"
    }
    tags = ["environment", "training"]
  }
  timeouts {
    create = "30m"
    update = "40m"
  }
}