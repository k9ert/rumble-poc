output "cluster_id" {
  description = "The UUID of the created cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.id
}

output "cluster_name" {
  description = "The name of the created cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.name
}

output "cluster_api_address" {
  description = "The API endpoint of the cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.api_address
}

output "cluster_status" {
  description = "The status of the cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.cluster_template_id
}

output "master_addresses" {
  description = "The addresses of the master nodes"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.master_addresses
}

output "node_addresses" {
  description = "The addresses of the worker nodes"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.node_addresses
}

output "stack_id" {
  description = "The Heat stack ID of the cluster"
  value       = openstack_containerinfra_cluster_v1.k8s_cluster.stack_id
}

output "kubeconfig_command" {
  description = "Command to get kubeconfig for the cluster"
  value       = "openstack coe cluster config ${openstack_containerinfra_cluster_v1.k8s_cluster.name}"
}

