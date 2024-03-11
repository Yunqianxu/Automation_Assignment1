variable "resource_group_name" {
  description = "The name of the resource group where the VMs and disks are located"
  type        = string
}

variable "location" {
  description = "The Azure location where the disks will be created"
  type        = string
}

variable "vm_ids" {
  description = "A list of VM IDs to which the data disks will be attached"
  type        = list(string)
}

variable "disk_size_gb" {
  description = "The size of the data disks in GB"
  default     = 10
}

variable "disk_count" {
  description = "The number of data disks to create and attach to each VM"
  default     = 4
}

variable "vm_names" {
type = list(string)
}

variable "tags" {

}