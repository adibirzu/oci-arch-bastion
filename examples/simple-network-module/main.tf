
# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

# in this example, TF isn't smart enough to handle the multiple dependencies... you need to run terraform apply -target=oci_core_network_security_group.test first, then terraform apply

module "oci_network" {
  source = "github.com/oracle/terraform-oci-tdf-network.git?ref=v0.9.7"

  default_compartment_id = var.default_compartment_id

  vcn_options = {
    display_name   = "simple test"
    cidr           = "192.168.0.0/19"
    enable_dns     = true
    dns_label      = "simpletest"
    compartment_id = null
    defined_tags   = null
    freeform_tags  = null
  }
}

module "bastion" {
  source = "../../"

  default_compartment_id = var.default_compartment_id

  vcn_id   = module.oci_network.vcn.id
  vcn_cidr = module.oci_network.vcn.cidr_block

  ssh_src_cidrs = [
    module.oci_network.vcn.cidr_block
  ]
  ssh_dst_cidrs = [
    module.oci_network.vcn.cidr_block
  ]

  compute_options = {
    compartment_id     = null
    ad                 = 0
    fd                 = null
    shape              = "VM.Standard2.1"
    public_ip          = true
    private_ip         = null
    defined_tags       = null
    freeform_tags      = null
    vnic_defined_tags  = null
    vnic_freeform_tags = null
    name               = "bastion"
    hostname_label     = "bastion"
    ssh_auth_keys      = var.ssh_pub_keys
    user_data          = null
    boot_vol_img_name  = var.image_name
    boot_vol_img_id    = null
    boot_vol_size      = null
    kms_key_id         = null
  }
}
