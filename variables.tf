# OpenStack Authentication Variables
variable "auth_url" {
  description = "OpenStack Keystone authentication URL"
  type        = string
  default     = "https://keystone.rumble.cloud/v3"
}

variable "application_credential_id" {
  description = "OpenStack Application Credential ID"
  type        = string
  sensitive   = true
}

variable "application_credential_secret" {
  description = "OpenStack Application Credential Secret"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "OpenStack region"
  type        = string
  default     = "RegionOne"
}

# Cluster Variables
# Note: Using standard template "Standard-v2.0-k8s-calico-fc38_v1.24.16"
# Template configuration (image, network driver, etc.) is managed by Rumble Cloud
variable "cluster_name" {
  description = "Name of the Kubernetes cluster"
  type        = string
  default     = "rumble-k8s-cluster"
}

variable "node_count" {
  description = "Number of worker nodes"
  type        = number
  default     = 1
}

variable "master_count" {
  description = "Number of master nodes"
  type        = number
  default     = 1
}

variable "keypair_name" {
  description = "SSH keypair name for cluster nodes"
  type        = string
}

variable "create_timeout" {
  description = "Cluster creation timeout in minutes"
  type        = number
  default     = 60
}

variable "environment" {
  description = "Environment label for the cluster"
  type        = string
  default     = "development"
}

