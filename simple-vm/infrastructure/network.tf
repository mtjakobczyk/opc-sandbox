# network.tf

resource "opc_compute_ip_address_reservation" "ip_rsv_public" {
  name            = "sandbox-vm-eth0-ip-rsv-public"
  ip_address_pool = "public-ippool"
}
resource "opc_compute_ip_address_reservation" "ip_rsv_cloud" {
  name            = "sandbox-vm-eth0-ip-rsv-cloud"
  ip_address_pool = "cloud-ippool"
}
resource "opc_compute_ip_address_association" "ip_asso_public" {
  name                   = "sandbox-vm-eth0-ip-asso-public"
  ip_address_reservation = "${opc_compute_ip_address_reservation.ip_rsv_public.name}"
  vnic                   = "sandbox-vm-eth0"
  depends_on = [ "opc_compute_instance.simplevm" ]
}
resource "opc_compute_ip_address_association" "ip_asso_cloud" {
  name                   = "sandbox-vm-eth0-ip-asso-cloud"
  ip_address_reservation = "${opc_compute_ip_address_reservation.ip_rsv_cloud.name}"
  vnic                   = "sandbox-vm-eth0"
  depends_on = [ "opc_compute_instance.simplevm" ]
}
