# compute.tf

resource "opc_compute_instance" "simplevm" {
  name = "sandbox-vm"
  storage {
    index = 1
    volume = "${opc_compute_storage_volume.simplevm_bootvolume.name}"
  }
  boot_order = [ 1 ]
  shape      = "oc3"
  networking_info {
    index          = 0
    vnic = "sandbox-vm-eth0"
    vnic_sets = [ "/Compute-123456789/second.user@example.com/sandbox-ip-network-vnics" ]
    ip_network     = "/Compute-123456789/second.user@example.com/sandbox-ip-network"
    shared_network = false
    dns = [ "sandboxvm.example.com" ]
    name_servers = [  ]
    is_default_gateway = true
  }
  hostname = "sandboxvm"
  ssh_keys = [ "key-sample" ]
}
locals {
  vm_networking = "${flatten(opc_compute_instance.simplevm.*.networking_info)}"
}

resource "opc_compute_storage_volume" "simplevm_bootvolume" {
  name        = "sandbox-vm-volume"
  size        = 15
  bootable    = true
  image_list  = "/Compute-123456789/first.user@example.com/OL76_UEKR5"
  image_list_entry = 1
}

resource "opc_compute_ssh_key" "key_sample" {
  name    = "key-sample"
  key     = "${file("~/Keys/oci_id_rsa.pub")}"
  enabled = true
}
