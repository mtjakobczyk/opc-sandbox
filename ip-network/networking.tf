# network.tf
resource "opc_compute_ip_network" "ipnet" {
  name                = "sandbox-ip-network"
  ip_address_prefix   = "192.168.1.0/24"
}
resource "opc_compute_ip_address_prefix_set" "ipnet_prefixes" {
  name     = "sandbox-ip-network-prefixes"
  prefixes = ["192.168.1.0/24" ]
}
resource "opc_compute_acl" "ipnet_acl" {
  name        = "sandbox-ip-network-acl"
}
resource "opc_compute_security_rule" "ipnet_ingress" {
  name               = "sandbox-ip-network-ingress"
  flow_direction     = "ingress"
  acl                = "${opc_compute_acl.ipnet_acl.name}"
  security_protocols = [ "/oracle/public/ssh", "/oracle/public/ping" ]
  dst_ip_address_prefixes = [ "${opc_compute_ip_address_prefix_set.ipnet_prefixes.name }" ]
}
resource "opc_compute_security_rule" "ipnet_egress" {
  name               = "sandbox-ip-network-egress"
  flow_direction     = "egress"
  acl                = "${opc_compute_acl.ipnet_acl.name}"
  src_ip_address_prefixes = [ "${opc_compute_ip_address_prefix_set.ipnet_prefixes.name }" ]
}
resource "opc_compute_vnic_set" "ipnet_vnics" {
  name         = "sandbox-ip-network-vnics"
  applied_acls = [ "${opc_compute_acl.ipnet_acl.name}" ]
}
