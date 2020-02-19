# OCI Bastion Module Example (Simple)

## Introduction

| Complexity |
|---|
| Simple |

This example shows how to utilize the bastion module in a very simplistic way, generating a VCN along with some accompanying resources.  Here are all of the resources created in this example:

* 1x Network Core Module
  * 1x VCN
  * 3x Route Tables
  * 2x DHCP Options
  * 1x VCN-wide Security List
  * 1x IGW
  * 1x NATGW
  * 1x SVCGW
  * 1x DRG
* 1x Bastion Module
  * 1x Subnet
  * 1x Compute Instance
  * 1x NSG
  * NSG rules

This example shows how the bastion module can be used with the network module.  It creates a publicly-accessible bastion.

## Topology Diagram
This example is intended to the following OCI topology:

![Topology diagram](./docs/Example-simple.png)

## Using this example
Prepare one variable file named `terraform.tfvars` with the required information (or feel free to copy the contents from `terraform.tfvars.template`).  The contents of `terraform.tfvars` should look something like the following:

```
tenancy_ocid = "ocid1.tenancy.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
user_ocid = "ocid1.user.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
fingerprint= "xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx:xx"
private_key_path = "~/.oci/oci_api_key.pem"
region = "us-phoenix-1"
default_compartment_ocid = "ocid1.compartment.oc1..xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
default_ssh_auth_keys=[ "<path to your public SSH key(s)>" ]
# see https://docs.cloud.oracle.com/iaas/images/ for a listing of OCI-provided image OCIDs
default_img_id="<image OCID>"
default_img_name="<image name>"
```

Then apply the example using the following commands:

```
$ terraform init
$ terraform plan
$ terraform apply
```
