
output "out_hub_vpc_self_link" {
     value = "${google_compute_network.hub_vpc.self_link}"
}
output "out_consumer_vpc_self_link" {
     value = "${google_compute_network.consumer_vpc.self_link}"
}
