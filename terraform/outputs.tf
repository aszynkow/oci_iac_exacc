output "stack_name" {
  description = "Name of this Terraform stack."
  value       = local.stack_name
}

output "compartment_ocid" {
  description = "Target compartment OCID supplied to the stack."
  value       = local.cloud_vm_cluster_compartment_id
}

output "cloud_vm_cluster_id" {
  description = "OCID of the ExaCC cloud VM cluster."
  value       = oci_database_cloud_vm_cluster.test.id
}
