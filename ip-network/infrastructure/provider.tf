# provider.tf
provider "opc" {
  user            = "${var.occ_user}"
  password        = "${var.occ_password}"
  identity_domain = "${var.occ_domain}"
  endpoint        = "${var.occ_endpoint}"
}
