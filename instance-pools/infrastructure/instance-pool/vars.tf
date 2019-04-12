# ipool module - vars.tf

# Module Input Variables
variable "instance_count" { }
variable "instance_prefix" { }
variable "instance_image" { }
variable "instance_shape" { }
variable "volume_size" { }
variable "ip_network" { }
variable "vnic_set" { }
variable "dns_prefix" { }
variable "dns_suffix" { }
variable "ssh_keys" { type="list" default = [] }
variable "name_servers" { type="list" default = [] }
