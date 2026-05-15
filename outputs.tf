output "stack_name" {
  description = "Name of this Terraform stack."
  value       = local.stack_name
}

output "compartment_ocid" {
  description = "Target compartment OCID supplied to the stack."
  value       = var.compartment_ocid
}
