variable "tenancy_ocid" {
  description = "OCI tenancy OCID."
  type        = string
}

variable "compartment_ocid" {
  description = "OCI compartment OCID where ExaCC resources will be managed."
  type        = string
}

variable "region" {
  description = "OCI region identifier."
  type        = string
}

variable "exacc_display_name" {
  description = "Display name for the Exadata Cloud@Customer deployment."
  type        = string
  default     = "exacc"
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
