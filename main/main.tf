provider "google" {
  project     = "${var.var_project}"
}

module "vpc" {
  source = "../modules/global" 
  env                   = "${var.var_env}"
  company               = "${var.var_company}"
  var_var_hub_pan_subnet = "${var.hub_pan_subnet}"
  var_var_hub_spoke1_mysql_subnet= "${var.hub_spoke1_mysql_subnet}"
  var_consumer_mysqlclient_subnet = "${var.consumer_mysqlclient_subnet}"
}

module "hub" {
  source                = "../modules/hub"
  network_self_link     = "${module.hub_vpc.out_vpc_self_link}"
  subnetwork1           = "${module.uc1.uc1_out_public_subnet_name}"
  env                   = "${var.var_env}"
  company               = "${var.var_company}"
  var_var_hub_pan_subnet = "${var.hub_pan_subnet}"
  var_var_hub_spoke1_mysql_subnet= "${var.var_hub_spoke1_mysql_subnet}"
}

module "consumer" {
  source                = "../modules/consumer"
  network_self_link     = "${module.consumer_vpc.out_vpc_self_link}"
  subnetwork1           = "${module.ue1.ue1_out_public_subnet_name}"
  env                   = "${var.var_env}"
  company               = "${var.var_company}"
  var_consumer_mysqlclient_subnet = "${var.consumer_mysqlclient_subnet}"
  var_ue1_private_subnet= "${var.ue1_private_subnet}"
}
######################################################################
# Display Output Public Instance
######################################################################
output "uc1_public_address"  { value = "${module.uc1.uc1_pub_address}"}
output "uc1_private_address" { value = "${module.uc1.uc1_pri_address}"}
output "ue1_public_address"  { value = "${module.ue1.ue1_pub_address}"}
output "ue1_private_address" { value = "${module.ue1.ue1_pri_address}"}
output "vpc_self_link" { value = "${module.vpc.out_vpc_self_link}"}