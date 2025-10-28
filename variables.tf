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

# Cluster Template Variables
variable "template_name" {
  description = "Name of the cluster template"
  type        = string
  default     = "kubernetes-template"
}

variable "image" {
  description = "OS image for cluster nodes"
  type        = string
  default     = "FedoraCoreOS-38"
}

variable "coe" {
  description = "Container orchestration engine"
  type        = string
  default     = "kubernetes"
}

variable "flavor" {
  description = "Flavor for worker nodes"
  type        = string
  default     = "s1a.small"
}

variable "master_flavor" {
  description = "Flavor for master nodes"
  type        = string
  default     = "s1a.small"
}

variable "external_network_id" {
  description = "External network ID or name"
  type        = string
  default     = "public"
}

variable "network_driver" {
  description = "Network driver (flannel or calico)"
  type        = string
  default     = "flannel"
}

variable "volume_driver" {
  description = "Volume driver"
  type        = string
  default     = "cinder"
}

variable "dns_nameserver" {
  description = "DNS nameserver for the cluster"
  type        = string
  default     = "8.8.8.8"
}

variable "kubernetes_version" {
  description = "Kubernetes version tag"
  type        = string
  default     = "v1.28.3"
}

# Cluster Variables
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

