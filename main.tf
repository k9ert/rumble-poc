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

# Create a Magnum Cluster Template
resource "openstack_containerinfra_clustertemplate_v1" "k8s_template" {
  name                  = var.template_name
  image                 = var.image
  coe                   = var.coe
  flavor                = var.flavor
  master_flavor         = var.master_flavor
  external_network_id   = var.external_network_id
  network_driver        = var.network_driver
  volume_driver         = var.volume_driver
  dns_nameserver        = var.dns_nameserver
  docker_storage_driver = "overlay2"
  docker_volume_size    = 20
  server_type           = "vm"
  public                = false
  tls_disabled          = false
  registry_enabled      = false
  master_lb_enabled     = true
  floating_ip_enabled   = true

  labels = {
    kube_tag                      = var.kubernetes_version
    cloud_provider_tag            = "v1.28.0"
    cloud_provider_enabled        = "true"
    auto_healing_enabled          = "true"
    auto_scaling_enabled          = "false"
    monitoring_enabled            = "true"
    auto_healing_controller       = "magnum-auto-healer"
    magnum_auto_healer_tag        = "v1.28.0"
    master_lb_floating_ip_enabled = "true"
    cinder_csi_enabled            = "true"
  }
}

# Create a Kubernetes Cluster
resource "openstack_containerinfra_cluster_v1" "k8s_cluster" {
  name                = var.cluster_name
  cluster_template_id = openstack_containerinfra_clustertemplate_v1.k8s_template.id
  keypair             = var.keypair_name
  node_count          = var.node_count
  master_count        = var.master_count
  create_timeout      = var.create_timeout

  labels = {
    environment = var.environment
  }
}
