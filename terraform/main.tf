locals {
  stack_name                      = "oci_iac_exacc"
  cloud_vm_cluster_compartment_id = trimspace(coalesce(var.exacs_compartment_id, "")) != "" ? var.exacs_compartment_id : var.compartment_ocid
  defined_tags                    = var.defined_tags
  freeform_tags = merge(
    {
      managed_by = "terraform"
      stack      = local.stack_name
    },
    var.freeform_tags
  )
}
