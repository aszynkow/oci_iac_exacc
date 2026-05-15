resource "oci_database_cloud_vm_cluster" "test" {
  backup_subnet_id                = var.vm_cluster_backup_subnet_id
  subnet_id                       = var.vm_cluster_subnet_id
  cloud_exadata_infrastructure_id = local.infra_id
  hostname                        = var.vm_cluster_hostname
  display_name                    = var.vm_cluster_display_name
  compartment_id                  = local.cloud_vm_cluster_compartment_id
  cpu_core_count                  = var.vm_cluster_cpu_core_count
  data_storage_size_in_tbs        = var.vm_cluster_data_storage_size_in_tbs
  db_node_storage_size_in_gbs     = var.vm_cluster_db_node_storage_size_in_gbs
  memory_size_in_gbs              = var.vm_cluster_memory_size_in_gbs
  gi_version                      = var.vm_cluster_gi_version
  license_model                   = var.vm_cluster_license_model
  is_local_backup_enabled         = var.vm_cluster_is_local_backup_enabled
  is_sparse_diskgroup_enabled     = var.vm_cluster_is_sparse_diskgroup_enabled
  ssh_public_keys                 = local.vm_cluster_ssh_public_keys
  db_servers = [
    data.oci_database_db_servers.db_servers.db_servers[0].id,
    data.oci_database_db_servers.db_servers.db_servers[1].id
  ]
  defined_tags  = local.defined_tags
  freeform_tags = local.freeform_tags
}
