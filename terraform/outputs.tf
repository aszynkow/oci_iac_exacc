output "stack_name" {
  description = "Name of this Terraform stack."
  value       = local.stack_name
}

output "compartment_ocid" {
  description = "Target compartment OCID supplied to the stack."
  value       = local.vm_cluster_compartment_id
}

output "vm_cluster_id" {
  description = "OCID of the ExaCC VM cluster."
  value       = oci_database_vm_cluster.test_vm_cluster.id
}

output "availability_domain" {
  description = "Availability domain resolved by the AD1 data source."
  value       = local.availability_domain
}
