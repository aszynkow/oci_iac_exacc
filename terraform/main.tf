locals {
  stack_name                      = "oci_iac_exacc"
  infra_id                        = var.cloud_exadata_infrastructure_id
  availability_domain             = data.oci_identity_availability_domain.AD1.name
  cloud_vm_cluster_compartment_id = var.compartment_ocid
  vm_cluster_ssh_public_keys      = compact([for key in split(",", var.vm_cluster_ssh_public_keys) : trimspace(key)])
  defined_tags                    = var.defined_tags
  freeform_tags = merge(
    {
      managed_by = "terraform"
      stack      = local.stack_name
    },
    var.freeform_tags
  )
}
