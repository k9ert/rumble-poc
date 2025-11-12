terraform {
  required_version = ">= 1.0"

  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 2.0"
    }
  }
}

provider "openstack" {
  auth_url                      = var.auth_url
  application_credential_id     = var.application_credential_id
  application_credential_secret = var.application_credential_secret
  region                        = var.region
}

# Reference the standard Magnum Cluster Template provided by Rumble Cloud
# Using the recommended template: Standard-v2.0-k8s-calico-fc38_v1.24.16
data "openstack_containerinfra_clustertemplate_v1" "k8s_template" {
  name = "Standard-v2.0-k8s-calico-fc38_v1.24.16"
}

# Create a Kubernetes Cluster
resource "openstack_containerinfra_cluster_v1" "k8s_cluster" {
  name                = var.cluster_name
  cluster_template_id = data.openstack_containerinfra_clustertemplate_v1.k8s_template.id
  keypair             = var.keypair_name
  node_count          = var.node_count
  master_count        = var.master_count
  create_timeout      = var.create_timeout

  labels = {
    environment = var.environment
  }
}
