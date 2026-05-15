locals {
  stack_name   = "oci_iac_exacc"
  defined_tags = var.defined_tags
  freeform_tags = merge(
    {
      managed_by = "terraform"
      stack      = local.stack_name
    },
    var.freeform_tags
  )
}
