resource "random_id" "id" {
      byte_length = 4
}

resource "google_compute_instance" "panwva" {
  name         = "panwva-${random_id.id.hex}"
  machine_type = "e2-medium"
  
  tags = ["panwva"]

  can_ip_forward = true
  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/debian-10-buster-v20220303"
    }
  }

  network_interface {
        network = "${var.network_self_link}"
        subnetwork = "${var.subnetwork_self_link}"
    }

    metadata = {
      startup-script = <<-EOF1
      #! /bin/bash
      apt-get update
      sudo apt-get install tcpdump -y
      echo 1 > /proc/sys/net/ipv4/ip_forward
      #Start iptables:
      sudo /sbin/iptables -t nat -F
      csql_fr1=10.0.9.3
      sock5_fr=10.0.8.2
      ens4_ip="$(curl -H "Metadata-Flavor:Google" http://169.254.169.254/computeMetadata/v1/instance/network-interfaces/0/ip)"
      sudo iptables -t nat -A POSTROUTING -o ens4 -j SNAT --to-source $ens4_ip
      sudo iptables -t nat -A PREROUTING -p tcp -d $ens4_ip --dport 3306 -j DNAT --to $csql_fr1
      sudo iptables -t nat -A PREROUTING -p tcp -d $ens4_ip --dport 1080 -j DNAT --to $sock5_fr
      sudo /sbin/iptables-save
      EOF1
    }
    service_account {
      scopes = ["cloud-platform"]
    }
}