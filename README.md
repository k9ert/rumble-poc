# Rumble Cloud - Kubernetes with Magnum

Deploy Kubernetes clusters on Rumble Cloud using OpenStack Magnum and Terraform.

## Overview

This repository uses Terraform with the OpenStack provider to deploy Kubernetes clusters via Magnum (OpenStack's Container Infrastructure service). This approach is based on [StackHPC's terraform-magnum](https://github.com/stackhpc/terraform-magnum).

**Default Configuration:** Minimum viable cluster
- 1 master node (s1a.small)
- 1 worker node (s1a.small)
- **Requirements:** 4 shared vCPUs, 4 GB RAM, 180 GB Block Storage, 3 Public IPs

## Prerequisites

- Terraform >= 1.0
- OpenStack credentials for Rumble Cloud
- SSH keypair created in OpenStack
- Access to Rumble Cloud at `https://keystone.rumble.cloud/`
- **Minimum Quota:** 4 vCPUs, 4 GB RAM, 180 GB storage, 3 floating IPs

## Quick Start

### 1. Configure Credentials

Copy the example configuration:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your credentials:

```hcl
application_credential_id     = "your-app-credential-id"
application_credential_secret = "your-app-credential-secret"
keypair_name                  = "your-keypair-name"
```

### 2. Deploy the Cluster

```bash
# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Deploy the cluster
terraform apply
```

### 3. Access Your Cluster

After deployment (takes ~15-20 minutes), get the kubeconfig:

```bash
# Using OpenStack CLI
openstack coe cluster config rumble-k8s-cluster

# Set kubeconfig
export KUBECONFIG=$(pwd)/config

# Verify access
kubectl get nodes
```

## Configuration

### Main Variables

Edit `terraform.tfvars` to customize:

| Variable | Description | Default |
|----------|-------------|---------|
| `cluster_name` | Name of the K8s cluster | `rumble-k8s-cluster` |
| `keypair_name` | SSH keypair (required) | - |
| `node_count` | Number of worker nodes | `1` |
| `master_count` | Number of master nodes | `1` |
| `flavor` | Worker node flavor | `s1a.small` |
| `master_flavor` | Master node flavor | `s1a.small` |
| `network_driver` | Network driver | `flannel` |
| `kubernetes_version` | Kubernetes version | `v1.28.3` |

### Scaling

To scale the cluster, update `node_count` in `terraform.tfvars` and run:

```bash
terraform apply
```

## Architecture

```
┌─────────────────────────────────────────────────┐
│   Rumble Cloud (OpenStack)                      │
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │  Magnum Cluster Template                   │ │
│  │  - Fedora CoreOS                           │ │
│  │  - Kubernetes v1.28.3                      │ │
│  │  - Flannel networking                      │ │
│  │  - Cinder volumes                          │ │
│  │  - s1a.small flavor (2 vCPU, 2 GB RAM)    │ │
│  └────────────────────────────────────────────┘ │
│              │                                   │
│              ▼                                   │
│  ┌────────────────────────────────────────────┐ │
│  │  Minimum Kubernetes Cluster (2 nodes)     │ │
│  │                                            │ │
│  │  ┌──────────────┐    ┌──────────────┐    │ │
│  │  │   Master     │    │   Worker     │    │ │
│  │  │  s1a.small   │    │  s1a.small   │    │ │
│  │  │  2vCPU/2GB   │    │  2vCPU/2GB   │    │ │
│  │  └──────────────┘    └──────────────┘    │ │
│  │                                            │ │
│  └────────────────────────────────────────────┘ │
│                                                  │
│  Total: 4 vCPUs, 4 GB RAM, 3 Floating IPs       │
└─────────────────────────────────────────────────┘
```

## Features

- ✅ **Autoscaling** - Kubernetes cluster autoscaler support
- ✅ **Persistent Volumes** - Cinder volume integration
- ✅ **Load Balancing** - Octavia load balancer for master nodes
- ✅ **High Availability** - Multi-master support
- ✅ **Auto-healing** - Automatic node recovery

## Troubleshooting

### Check Cluster Status

```bash
openstack coe cluster list
openstack coe cluster show rumble-k8s-cluster
```

### View Logs

```bash
# Get the Heat stack ID
openstack coe cluster show rumble-k8s-cluster -f value -c stack_id

# View stack events
openstack stack event list <stack-id>
```

### Common Issues

**Cluster stuck in CREATE_IN_PROGRESS**
- Check Heat stack events: `openstack stack event list <stack-id>`
- Verify network connectivity and quotas

**Cannot access cluster**
- Verify security group rules allow access
- Check floating IP assignment
- Ensure correct keypair is configured

## Cleanup

To destroy the cluster:

```bash
terraform destroy
```

## References

- [Rumble Cloud Terraform Guide](https://docs.rumble.cloud/guides/terraform/introduction_to_terraform_on%20rumble_cloud.html)
- [OpenStack Magnum Documentation](https://docs.openstack.org/magnum/latest/)
- [StackHPC Terraform Magnum](https://github.com/stackhpc/terraform-magnum)
