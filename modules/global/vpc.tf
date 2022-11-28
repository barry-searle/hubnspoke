resource "google_compute_network_peering" "hub_to_consumer" {
  name         = "peering1"
  network      = google_compute_network.hub_vpc.self_link
  peer_network = google_compute_network.consumer_vpc.self_link
}

resource "google_compute_network_peering" "consumer_to_hub" {
  name         = "peering2"
  network      = google_compute_network.consumer_vpc.self_link
  peer_network = google_compute_network.hub_vpc.self_link
}

resource "google_compute_network" "hub_vpc" {
  name          =  "${format("%s","${var.company}-${var.env}-hub-vpc")}"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}

resource "google_compute_network" "consumer_vpc" {
  name          =  "${format("%s","${var.company}-${var.env}-consumer-vpc")}"
  auto_create_subnetworks = "false"
  routing_mode            = "REGIONAL"
}


resource "google_compute_global_address" "private_ip_block" {
  name         = "private-ip-block"
  purpose      = "VPC_PEERING"
  address_type = "INTERNAL"
  ip_version   = "IPV4"
  #address    = "10.0.9.0"
  prefix_length = 24
  network       = google_compute_network.hub_vpc.self_link
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = google_compute_network.hub_vpc.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_block.name]
}

resource "google_compute_firewall" "allow-internal" {
  name    = "${var.company}-fw-allow-internal"
  network = "${google_compute_network.hub_vpc.name}"
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  source_ranges = [
    "${var.hub_pan_subnet}",
    "${var.hub_spoke1_mysql_subnet}",
  ]
}

/*resource "google_compute_firewall" "allow-hub-socks5" {
  name    = "${google_compute_network.hub_vpc.name}-fw-allow-socks5"
  network = "${google_compute_network.hub_vpc.name}"
allow {
    protocol = "tcp"
    ports    = ["1080"]
  }
  target_tags = ["panwva"] 

   source_ranges = [
    "${var.hub_pan_subnet}"
  ]
}*/

resource "google_compute_firewall" "allow-hub-ssh" {
  name    = "${google_compute_network.hub_vpc.name}-fw-allow-ssh"
  network = "${google_compute_network.hub_vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = ["panwva"]

  source_ranges = [
    "${var.hub_pan_subnet}",
    "${var.hub_spoke1_mysql_subnet}",
  ]
  }

  resource "google_compute_firewall" "allow-hub-mysql" {
  name    = "${google_compute_network.hub_vpc.name}-fw-allow-mysql"
  network = "${google_compute_network.hub_vpc.name}"
  allow {
    protocol = "tcp"
    ports    = ["3306"]
  }
  target_tags = ["panwva"]

    source_ranges = [
    "${var.hub_pan_subnet}",
    "${var.hub_spoke1_mysql_subnet}",
    "${var.consumer_mysqlclient_subnet}",
  ]
  }


resource "google_compute_firewall" "allow-socks5" {
  name    = "${google_compute_network.hub_vpc.name}-fw-allow-socks5"
  network = "${google_compute_network.hub_vpc.name}"

  allow {
    protocol = "tcp"
    ports    = ["1080"]
  }
  target_tags = ["socks5","panwva"]

   source_ranges = [
    "${var.hub_pan_subnet}",
    "${var.hub_spoke1_mysql_subnet}",
  ]
  }
