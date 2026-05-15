data "oci_identity_availability_domain" "AD1" {
  compartment_id = var.tenancy_ocid
  ad_number      = 1
}

data "oci_database_db_servers" "db_servers" {
  compartment_id            = var.exacs_compartment_id
  exadata_infrastructure_id = local.infra_id
}
