variable "tenancy_ocid" {
  description = "OCI tenancy OCID."
  type        = string
}

variable "compartment_ocid" {
  description = "Compartment OCID where the ExaCC VM cluster will be deployed."
  type        = string
}

variable "region" {
  description = "OCI region identifier."
  type        = string
}

variable "exacs_compartment_id" {
  description = "Compartment OCID for the existing ExaCC infrastructure and DB server lookup."
  type        = string
}

variable "exadata_infrastructure_id" {
  description = "Optional Exadata infrastructure OCID for the ExaCC VM cluster. If omitted, the first infrastructure in exacs_compartment_id is used."
  type        = string
  default     = null
}

variable "vm_cluster_network_id" {
  description = "VM cluster network OCID for the ExaCC VM cluster."
  type        = string
}

variable "vm_cluster_display_name" {
  description = "Display name for the ExaCC VM cluster."
  type        = string
  default     = "tmptest1"
}

variable "vm_cluster_cpu_core_count" {
  description = "Number of CPU cores enabled for the ExaCC VM cluster."
  type        = number
  default     = 4
}

variable "vm_cluster_data_storage_size_in_tbs" {
  description = "Data storage size in TBs for the ExaCC VM cluster."
  type        = number
  default     = 3
}

variable "vm_cluster_db_node_storage_size_in_gbs" {
  description = "Database node storage size in GBs for the ExaCC VM cluster."
  type        = number
  default     = 160
}

variable "vm_cluster_memory_size_in_gbs" {
  description = "Memory size in GBs for the ExaCC VM cluster."
  type        = number
  default     = 60
}

variable "vm_cluster_gi_version" {
  description = "Grid Infrastructure version for the ExaCC VM cluster."
  type        = string
  default     = "19.0.0.0"
}

variable "vm_cluster_license_model" {
  description = "Oracle Database license model for the ExaCC VM cluster."
  type        = string
  default     = "BRING_YOUR_OWN_LICENSE"

  validation {
    condition     = contains(["BRING_YOUR_OWN_LICENSE", "LICENSE_INCLUDED"], var.vm_cluster_license_model)
    error_message = "vm_cluster_license_model must be BRING_YOUR_OWN_LICENSE or LICENSE_INCLUDED."
  }
}

variable "vm_cluster_is_local_backup_enabled" {
  description = "Whether local backup is enabled for the ExaCC VM cluster."
  type        = bool
  default     = false
}

variable "vm_cluster_is_sparse_diskgroup_enabled" {
  description = "Whether sparse disk groups are enabled for the ExaCC VM cluster."
  type        = bool
  default     = false
}

variable "vm_cluster_ssh_public_keys" {
  description = "SSH public keys authorized for the ExaCC VM cluster."
  type        = string
  default     = ""
}

variable "defined_tags" {
  description = "Defined tags to apply to supported OCI resources."
  type        = map(string)
  default     = {}
}

variable "freeform_tags" {
  description = "Freeform tags to apply to supported OCI resources."
  type        = map(string)
  default     = {}
}
