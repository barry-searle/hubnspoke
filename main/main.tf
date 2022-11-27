provider "google" {
  project     = "${var.var_project}"
  #credentials = "${file("../../hubnspoke-d13b7af7381c.json")}"
  credentials = var.GOOGLE_CREDENTIALS
}

module "vpc" {
  source = "../modules/global" 
  env                   = "${var.var_env}"
  company               = "${var.var_company}"
  hub_pan_subnet    = "${var.hub_pan_subnet}"
  hub_spoke1_mysql_subnet= "${var.hub_spoke1_mysql_subnet}"
  consumer_mysqlclient_subnet = "${var.consumer_mysqlclient_subnet}"
}

module "hub" {
  source                = "../modules/hub"
  network_self_link     = "${module.vpc.out_hub_vpc_self_link}"
  region_name          = "${var.var_region}"
  #subnetwork1           = "${module.uc1.uc1_out_public_subnet_name}"
  env                   = "${var.var_env}"
  company               = "${var.var_company}"
  hub_pan_subnet    = "${var.hub_pan_subnet}"
  hub_spoke1_mysql_subnet= "${var.hub_spoke1_mysql_subnet}"
}

module "consumer" {
  source                = "../modules/consumer"
  network_self_link     = "${module.vpc.out_consumer_vpc_self_link}"
  region_name          = "${var.var_region}"
  #subnetwork1           = "${module.consumer.ue1_out_public_subnet_name}"
  env                   = "${var.var_env}"
  company               = "${var.var_company}"
  consumer_mysqlclient_subnet = "${var.consumer_mysqlclient_subnet}"
  #ue1_private_subnet= "${var.ue1_private_subnet}"
}
