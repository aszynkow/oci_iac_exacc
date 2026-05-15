variable "tenancy_ocid" {
  description = "OCI tenancy OCID."
  type        = string
}

variable "compartment_ocid" {
  description = "Default OCI compartment OCID where ExaCC resources will be managed."
  type        = string
}

variable "region" {
  description = "OCI region identifier."
  type        = string
}

variable "exacs_compartment_id" {
  description = "Optional compartment OCID for the ExaCC VM cluster. If omitted, compartment_ocid is used."
  type        = string
  default     = null
}

variable "cloud_exadata_infrastructure_id" {
  description = "Cloud Exadata infrastructure OCID for the VM cluster."
  type        = string
}

variable "vm_cluster_backup_subnet_id" {
  description = "Backup subnet OCID for the ExaCC VM cluster."
  type        = string
  default     = "ocid1.subnet.oc1.ap-sydney-1.aaaaaaaavlyovx3jevo5w3h2abqhn272bmazbusywbrqggwrg47hvx325ofa"
}

variable "vm_cluster_subnet_id" {
  description = "Client subnet OCID for the ExaCC VM cluster."
  type        = string
  default     = "ocid1.subnet.oc1.ap-sydney-1.aaaaaaaahyaolzmux7eiy7ihe2tgyconfclthowvo2426xmvvdbkmoee64nq"
}

variable "vm_cluster_hostname" {
  description = "Hostname prefix for the ExaCC VM cluster."
  type        = string
  default     = "tmptest1"
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
  type        = list(string)
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCg2WY8V4RGgS1Q6yI3Yj8ZlQzZLfp4S17bcxUuXqiUF/MSDkroKI1qUBRrjjvBKvi/Yl2j7KGtCYxbjftGydlpjNO/iMQGSlf4gDTGUnFT0l/QnDdMtXg9GtTtrGrYuh8aXqjMWvF2dyt6MkH0em80rVoN0VC+pu7emjeVRoWPrWlh1TkchFvfpT+WtrT7nyDLDES1UEAaFEhGFZ+y8joHPe8iaumq2xAUVcTsF8Sd759F51qLpo814ivnfi/+W9e6Al6wtSoK7d0y+lvuSCWgbFdf12o+F4ZF04oJlMuRj2itzT1QztAFCzEpQk0KdRzsCO/d/mpV1gFREEFb8IBLI01w+gzqXv5EKIBHOiDZBvsNrXpFPcF5O+gyf2ay377zJ8cRVyJgo4rPr5vNSY/zGuE1Ttw6bnGc4xpuIdgl4txuEKJiaqtXYxhSxu2dtBeJHqCt62sLMkyOhq/kpW0mgr5N+jqUdGqnLqBtIbRZAcsShe8lVwCyfSvkbRiBNts= jason.grogan@dhcp-10-191-135-197.vpn.oracle.com"
  ]
}

variable "vm_cluster_db_server_ids" {
  description = "DB server OCIDs to place in the ExaCC VM cluster."
  type        = list(string)
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
