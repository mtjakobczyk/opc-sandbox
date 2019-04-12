# instance-pool module - networking.tf

resource "opc_compute_ip_address_reservation" "ip_rsv_public" {
  count = "${var.instance_count}"
  name            = "${var.instance_prefix}${count.index + 1}-eth0-ip-rsv-public"
  ip_address_pool = "public-ippool"
}
resource "opc_compute_ip_address_reservation" "ip_rsv_cloud" {
  count = "${var.instance_count}"
  name            = "${var.instance_prefix}${count.index + 1}-eth0-ip-rsv-cloud"
  ip_address_pool = "cloud-ippool"
}

resource "opc_compute_ip_address_association" "ip_asso_public" {
  count = "${var.instance_count}"
  name                   = "${var.instance_prefix}${count.index + 1}-eth0-ip-asso-public"
  ip_address_reservation = "${opc_compute_ip_address_reservation.ip_rsv_public.*.name[count.index]}"
  vnic                   = "${var.instance_prefix}${count.index + 1}-eth0"
  depends_on = [ "opc_compute_instance.inst" ]
}
resource "opc_compute_ip_address_association" "ip_asso_cloud" {
  count = "${var.instance_count}"
  name                   = "${var.instance_prefix}${count.index + 1}-eth0-ip-asso-cloud"
  ip_address_reservation = "${opc_compute_ip_address_reservation.ip_rsv_cloud.*.name[count.index]}"
  vnic                   = "${var.instance_prefix}${count.index + 1}-eth0"
  depends_on = [ "opc_compute_instance.inst" ]
}

# Outputs
output "instance_public_ips" {
  value = "${opc_compute_ip_address_reservation.ip_rsv_public.*.ip_address}"
}
