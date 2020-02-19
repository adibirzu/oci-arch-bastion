# Copyright (c) 2020, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.


# in this example, TF isn't smart enough to handle the multiple dependencies... you need to run terraform apply -target=oci_core_network_security_group.test first, then terraform apply

module "bastion" {
  source = "../../"
  # depends_on      = [ oci_core_network_security_group.test ]

  default_compartment_id = var.default_compartment_id
  vcn_id                = oci_core_vcn.this.id
  vcn_cidr              = oci_core_vcn.this.cidr_block
  
  create_subnet         = false
  existing_subnet_id    = oci_core_subnet.test.id

  ssh_src_cidrs         = [
    oci_core_vcn.this.cidr_block
  ]
  ssh_dst_cidrs         = [
    oci_core_vcn.this.cidr_block
  ]
  
  compute_options       = {
    compartment_id      = null
    ad                  = 0
    fd                  = null
    shape               = "VM.Standard2.1"
    public_ip           = true
    private_ip          = null
    defined_tags        = null
    freeform_tags       = null
    vnic_defined_tags   = null
    vnic_freeform_tags  = null
    name                = "bastion"
    hostname_label      = "bastion"
    ssh_auth_keys       = var.ssh_pub_keys
    user_data           = null
    boot_vol_img_name   = var.image_name
    boot_vol_img_id     = null
    boot_vol_size       = null
    kms_key_id          = null
  }
}

resource "oci_core_subnet" "test" {
    cidr_block          = "192.168.100.0/24"
    compartment_id      = var.default_compartment_id
    vcn_id              = oci_core_vcn.this.id
    display_name        = "test"
    dns_label           = "test"
    prohibit_public_ip_on_vnic = false
}

resource "oci_core_vcn" "this" {
  dns_label             = "temp"
  cidr_block            = "192.168.0.0/16"
  compartment_id        = var.default_compartment_id
  display_name          = "temp"
}
