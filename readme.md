
## Requirements and Prerequisites

1. An AWS account
2. A system with [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) and [kubectl](https://kubernetes.io/docs/tasks/tools/) installed
3. Knowledge of syntax and structure of the Terraform configuration file.

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

The module can be used to create a new VPC or use an existing one, along with its associated resources such as Subnets, Route Tables, Security Groups, Network ACL(s) (NACL), and Internet Gateway (IGW). It offers a simplified and standardized way to create VPC infrastructure, while also providing flexibility to customize VPC resources based on specific requirements.

The [squareops/vpc/aws](https://registry.terraform.io/modules/squareops/vpc/aws/latest) module offers a range of configuration options, including the ability to specify CIDR blocks for VPC and subnet ranges, assign names and tags to VPC resources, enable DNS support, and configure NAT gateways. Additionally, the module provides pre-configured modules for creating subnets with different availability zones(AZs), route tables, and security groups.

By using this module, AWS users can save time and effort in setting up VPC infrastructure, and ensure that their VPCs are created in a consistent and reproducible manner. The module is open source and maintained by [SquareOps](https://squareops.com/), a consulting company that specializes in cloud infrastructure and DevOps automation.

### EKS

The [squareops/eks/aws](https://registry.terraform.io/modules/squareops/eks/aws/latest) module available on the Terraform Registry is designed to create and manage an EKS (Elastic Kubernetes Service) cluster in AWS (Amazon Web Services).

The module provides a simplified and standardized way to create and manage the kubernetes control plane and worker nodes in EKS. It automates the process of creating the necessary EKS resources such as VPC, subnets, security groups, IAM roles and policies, and the EKS cluster itself.

The [squareops/eks/aws](https://registry.terraform.io/modules/squareops/eks/aws/latest) module offers a range of configuration options, such as the ability to specify the number of worker nodes, instance types, and desired capacity. It also provides pre-configured modules for configuring worker node groups with different instance types, adding custom tags, and setting up the kubernetes metrics server.

By using this module, AWS users can set up a kubernetes cluster on EKS in a simple, efficient, and reproducible manner. It also ensures that the EKS cluster is created with the best practices in mind, and that it is secured according to industry standards. The module is open source and maintained by [SquareOps](https://squareops.com/), a consulting company that specializes in cloud infrastructure and DevOps automation.

### EKS-BOOTSTRAP

The [squareops/eks-bootstrap/aws](https://registry.terraform.io/modules/squareops/eks-bootstrap/aws/latest) module available on the Terraform Registry is designed to bootstrap an EKS (Elastic Kubernetes Service) cluster in AWS (Amazon Web Services) with the necessary resources to run a kubernetes workload.

The module provides a simplified and standardized way to create the kubernetes worker nodes in EKS, and to deploy the necessary add-ons and configurations to run kubernetes workloads. It automates the process of creating the necessary EKS resources. 

By using this module, AWS users can save time and ensure that their kubernetes workloads are deployed in a consistent and reproducible manner. It also ensures that the EKS cluster is created with the best practices in mind, and that it is secured according to industry standards. The module is open source and maintained by [SquareOps](https://squareops.com/), a consulting company that specializes in cloud infrastructure and DevOps automation.
