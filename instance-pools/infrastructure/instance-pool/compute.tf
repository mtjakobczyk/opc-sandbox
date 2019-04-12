# instance-pool module - compute.tf

resource "opc_compute_instance" "inst" {
  count = "${var.instance_count}"
  name = "${var.instance_prefix}${count.index + 1}"
  storage {
    index = 1
    volume = "${opc_compute_storage_volume.instance_bootvolume.*.name[count.index]}"
  }
  boot_order = [ 1 ]
  shape      = "${var.instance_shape}"
  networking_info {
    index          = 0
    vnic = "${var.instance_prefix}${count.index + 1}-eth0"
    vnic_sets = [ "${var.vnic_set}" ]
    ip_network     = "${var.ip_network}"
    shared_network = false
    dns = [ "${var.dns_prefix}${count.index + 1}${var.dns_suffix}" ]
    name_servers = "${var.name_servers}"
    is_default_gateway = true
  }
  hostname = "${var.dns_prefix}${count.index + 1}"
  ssh_keys = "${var.ssh_keys}"
}
locals {
  vm_networking = "${flatten(opc_compute_instance.inst.*.networking_info)}"
}
