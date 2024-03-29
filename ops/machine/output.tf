
output "ip_controlplane" {
  value = google_compute_instance.default["controlplane"].network_interface.0.access_config.0.nat_ip
}

output "ip_worker1" {
  value = google_compute_instance.default["worker1"].network_interface.0.access_config.0.nat_ip
}