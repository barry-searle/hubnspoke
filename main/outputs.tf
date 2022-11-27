######################################################################
# Display Output Public Instance
######################################################################
#output "uc1_public_address"  { value = "${module.hub.uc1_pub_address}"}
#output "uc1_private_address" { value = "${module.uc1.uc1_pri_address}"}
#output "ue1_public_address"  { value = "${module.ue1.ue1_pub_address}"}
#output "ue1_private_address" { value = "${module.ue1.ue1_pri_address}"}
output "vpc_self_link" { value = "${module.vpc.out_hub_vpc_self_link}"}