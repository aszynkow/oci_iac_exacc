data "oci_identity_availability_domain" "AD1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_database_exadata_infrastructures" "exadata_infrastructures" {
  count          = trimspace(coalesce(var.exadata_infrastructure_id, "")) == "" ? 1 : 0
  compartment_id = var.exacs_compartment_id
}

data "oci_database_db_servers" "db_servers" {
  compartment_id            = var.exacs_compartment_id
  exadata_infrastructure_id = local.infra_id
}

data "oci_database_vm_cluster_networks" "vm_cluster_networks" {
  count                     = trimspace(coalesce(var.vm_cluster_network_id, "")) == "" ? 1 : 0
  compartment_id            = var.exacs_compartment_id
  exadata_infrastructure_id = local.infra_id
}
