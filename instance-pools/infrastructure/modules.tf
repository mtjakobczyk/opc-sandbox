# modules.tf

resource "opc_compute_ssh_key" "key_sample" {
  name    = "key-sample"
  key     = "${file("~/.ssh/sample_id_rsa.pub")}"
  enabled = true
}

module "instance_pool" {
  source = "instance-pool"
  instance_count = 2
  instance_prefix = "pool-1-instance-"
  instance_image = "/oracle/public/OL_7.2_UEKR4_x86_64"
  instance_shape = "oc3"
  volume_size = "15"
  ip_network = "/Compute-${var.occ_domain}/first.user@example.com/sandbox-ip-network"
  vnic_set = "/Compute-${var.occ_domain}/first.user@example.com/sandbox-ip-network-vnics"
  dns_prefix = "pool1instance"
  dns_suffix = ".example.com"
  ssh_keys = [ "/Compute-${var.occ_domain}/${var.occ_user}/key-sample" ]
  name_servers = [  ]
}
output "Instance Pool Public IPs" {
  value = "${module.instance_pool.instance_public_ips}"
}
