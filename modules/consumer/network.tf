resource "google_compute_subnetwork" "consumer_mysqlclient_subnet" {
  name          =  "${format("%s","${var.company}-${var.env}-${var.region_map["${var.var_region_name}"]}-consumer-mysqlclient-subnet")}"
  ip_cidr_range = "${var.consumer_mysqlclient_subnet}"
  network       = "${var.network_self_link}"
  region        = "${var.var_region_name}"
}