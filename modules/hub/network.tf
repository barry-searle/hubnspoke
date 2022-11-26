resource "google_compute_subnetwork" "hub_pan_subnet" {
  name          =  "${format("%s","${var.company}-${var.env}-${var.region_map["${var.var_region_name}"]}-hub-pan-subnet")}"
  ip_cidr_range = "${var.hub_pan_subnet}"
  network       = "${var.network_self_link}"
  region        = "${var.var_region_name}"
}
resource "google_compute_subnetwork" "hub_spoke1_mysql_subnet" {
  name          =  "${format("%s","${var.company}-${var.env}-${var.region_map["${var.var_region_name}"]}-hub-spoke1-mysql-subnet")}"
  ip_cidr_range = "${var.hub_spoke1_mysql_subnet}"
  network      = "${var.network_self_link}"
  region        = "${var.var_region_name}"
}