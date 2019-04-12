# ipool module - storage.tf

resource "opc_compute_storage_volume" "instance_bootvolume" {
  count = "${var.instance_count}"
  name        = "${var.instance_prefix}${count.index + 1}-volume"
  size        = "${var.volume_size}"
  bootable    = true
  image_list  = "${var.instance_image}"
  image_list_entry = 1
}
