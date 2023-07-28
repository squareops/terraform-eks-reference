## Terraform EKS Reference

Terraform reference to deploy a production ready EKS cluster. This reference takes care of provisioning a secure VPC network with VPN , deploy an EKS cluster and configure it with required resources,controllers and utilities to start deploying applications.

## Requirements and Prerequisites

1. An AWS account
2. A system with [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and [kubectl](https://kubernetes.io/docs/tasks/tools/) installed

This repository contains Terraform configuration files for deploying a set of modules in a specific order. The tfstate module must be deployed first, followed by main module.

## Deploying the tfstate Module

The tfstate module is used for storing the Terraform state file remotely, which is a recommended practice to ensure consistency and collaboration among team members.

To deploy the tfstate module, navigate to the **tfstate** directory and run the following commands:

1. terraform init
2. terraform plan
3. terraform apply

Once you have provided the required input, Terraform will create the necessary resources for the tfstate module.

## Deploying the EKS Cluster

After the tfstate module has been deployed, you can deploy the the EKS cluster setup. Creating an EKS cluster involves several steps, including setting up a Virtual Private Cloud (VPC), creating an EKS cluster, configuring an EKS node group, and bootstrapping the cluster.

### VPC

The [squareops/vpc/aws](https://registry.terraform.io/modules/squareops/vpc/aws/latest) module available on the Terraform Registry is designed to create and manage Virtual Private Cloud (VPC) resources in AWS (Amazon Web Services).

The module can be used to create a new VPC along with its associated resources such as Subnets, Route Tables, Security Groups, Network ACL(s) (NACL), and Internet Gateway (IGW). It offers a simplified and standardized way to create VPC infrastructure, while also providing flexibility to customize VPC resources based on specific requirements.

The [squareops/vpc/aws](https://registry.terraform.io/modules/squareops/vpc/aws/latest) module offers a range of configuration options, including the ability to specify CIDR blocks for VPC and subnet ranges, assign names and tags to VPC resources, enable DNS support, and configure NAT gateways. Additionally, the module provides pre-configured modules for creating subnets in different availability zones(AZs), route tables, and security groups.

By using this module, AWS users can save time and effort in setting up VPC infrastructure, and ensure that their VPCs are created in a consistent and reproducible manner. The module is open source and maintained by [SquareOps](https://squareops.com/), a consulting company that specializes in cloud infrastructure and DevOps automation.

### EKS

The [squareops/eks/aws](https://registry.terraform.io/modules/squareops/eks/aws/latest) module available on the Terraform Registry is designed to create and manage an EKS (Elastic Kubernetes Service) cluster in AWS (Amazon Web Services).

The module provides a simplified and standardized way to create and manage the kubernetes control plane and worker nodes in EKS. It automates the process of creating the necessary EKS resources such as security groups, IAM roles and policies, and the EKS cluster itself.

The [squareops/eks/aws](https://registry.terraform.io/modules/squareops/eks/aws/latest) module offers a range of configuration options, such as the ability to specify the number of worker nodes, instance types, and desired capacity. It also provides pre-configured modules for configuring worker node groups with different instance types, adding custom tags.

By using this module, AWS users can set up a kubernetes cluster on EKS in a simple, efficient, and reproducible manner. It also ensures that the EKS cluster is created with the best practices in mind, and that it is secured according to industry standards. The module is open source and maintained by [SquareOps](https://squareops.com/), a consulting company that specializes in cloud infrastructure and DevOps automation.


# terraform-eks-reference

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks"></a> [eks](#module\_eks) | squareops/eks/aws | 3.1.0 |
| <a name="module_key_pair_eks"></a> [key\_pair\_eks](#module\_key\_pair\_eks) | squareops/keypair/aws | 1.0.2 |
| <a name="module_key_pair_vpn"></a> [key\_pair\_vpn](#module\_key\_pair\_vpn) | squareops/keypair/aws | 1.0.2 |
| <a name="module_managed_node_group_production"></a> [managed\_node\_group\_production](#module\_managed\_node\_group\_production) | squareops/eks/aws//modules/managed-nodegroup | 3.1.0 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | squareops/vpc/aws | 3.3.0 |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Endpoint for EKS Control Plane |
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | EKS Cluster Name |
| <a name="output_cluster_oidc_issuer_url"></a> [cluster\_oidc\_issuer\_url](#output\_cluster\_oidc\_issuer\_url) | The URL on the EKS cluster for the OpenID Connect identity provider |
| <a name="output_cluster_security_group_id"></a> [cluster\_security\_group\_id](#output\_cluster\_security\_group\_id) | Security group IDs attached to the cluster control plane |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | List of IDs of Database Subnets |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | List of IDs of Intra Subnets |
| <a name="output_kms_policy_arn"></a> [kms\_policy\_arn](#output\_kms\_policy\_arn) | ARN of KMS policy |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | List of IDs of Private Subnets |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | List of IDs of Public Subnets |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpn_host_public_ip"></a> [vpn\_host\_public\_ip](#output\_vpn\_host\_public\_ip) | Public IP Adress of VPN Server |
| <a name="output_vpn_security_group"></a> [vpn\_security\_group](#output\_vpn\_security\_group) | Security Group ID of VPN Server |
| <a name="output_worker_iam_role_arn"></a> [worker\_iam\_role\_arn](#output\_worker\_iam\_role\_arn) | ARN of the EKS Worker Role |
| <a name="output_worker_iam_role_name"></a> [worker\_iam\_role\_name](#output\_worker\_iam\_role\_name) | The name of the EKS Worker IAM role |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
