locals {
  stack_name                           = "oci_iac_exacc"
  provided_exadata_infrastructure_id   = trimspace(coalesce(var.exadata_infrastructure_id, ""))
  discovered_exadata_infrastructure_id = try(data.oci_database_exadata_infrastructures.exadata_infrastructures[0].exadata_infrastructures[0].id, "")
  infra_id                             = local.provided_exadata_infrastructure_id != "" ? local.provided_exadata_infrastructure_id : local.discovered_exadata_infrastructure_id
  provided_vm_cluster_network_id       = trimspace(coalesce(var.vm_cluster_network_id, ""))
  discovered_vm_cluster_network_id     = try(data.oci_database_vm_cluster_networks.vm_cluster_networks[0].vm_cluster_networks[0].id, "")
  vm_cluster_network_id                = local.provided_vm_cluster_network_id != "" ? local.provided_vm_cluster_network_id : local.discovered_vm_cluster_network_id
  availability_domain                  = data.oci_identity_availability_domain.AD1.name
  vm_cluster_compartment_id            = var.compartment_ocid
  raw_vm_cluster_ssh_public_keys       = try(tolist(var.vm_cluster_ssh_public_keys), try(tolist(jsondecode(var.vm_cluster_ssh_public_keys)), [tostring(var.vm_cluster_ssh_public_keys)]))
  vm_cluster_ssh_public_keys           = compact(flatten([for value in local.raw_vm_cluster_ssh_public_keys : [for key in split(",", replace(replace(tostring(value), "\r", ""), "\n", ",")) : trimspace(key)]]))
  defined_tags                         = var.defined_tags
  freeform_tags = merge(
    {
      managed_by = "terraform"
      stack      = local.stack_name
    },
    var.freeform_tags
  )
}
