output "out_pan_subnet_name" {
     value = "${google_compute_subnetwork.hub_pan_subnet.name}"
}

output "hub_spoke1_mysql_subnet" {
     value = "${google_compute_subnetwork.hub_spoke1_mysql_subnet.name}"
}