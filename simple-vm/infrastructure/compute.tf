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
    vnic_sets = [ "${opc_compute_vnic_set.ipnet_vnics.name}" ]
    ip_network     = "${opc_compute_ip_network.ipnet.name}"
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
  image_list  = "/oracle/public/OL_7.2_UEKR4_x86_64"
  image_list_entry = 1
}

resource "opc_compute_ssh_key" "key_sample" {
  name    = "key-sample"
  key     = "${file("~/Keys/oci_id_rsa.pub")}"
  enabled = true
}
