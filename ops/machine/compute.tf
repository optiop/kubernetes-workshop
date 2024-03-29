

resource "google_service_account" "default" {
  account_id   = "kubernetes"
  display_name = "Custom Service Account to Learn Install Kubernetes"
}

resource "google_compute_network" "vpc_network" {
  name                    = "vpc-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "vpc-subnetwork"
  ip_cidr_range = "10.2.0.0/16"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_firewall" "allow_all" {
  name    = "allow-all"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = []
  }

  allow {
    protocol = "udp"
    ports    = []
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "default" {
  for_each = toset(["controlplane", "worker1"])
  name         = each.key
  machine_type = var.instance_size
  zone         = var.zone

  allow_stopping_for_update = true
  tags = ["kubernetes", "controller"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
      size = 40
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.vpc_subnetwork.id
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    ssh-keys = join("\n", [for key in var.ssh_keys : "${key.user}:${key.ssh_key}"])
  }

  metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
