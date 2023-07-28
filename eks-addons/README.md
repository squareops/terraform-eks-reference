# eks-bootstrap

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

To deploy eks-bootstrap need vpc,eks and node-group should be deployed.
## Deploying the EKS BOOTSTRAP
### EKS-BOOTSTRAP

The [squareops/eks-bootstrap/aws](https://registry.terraform.io/modules/squareops/eks-bootstrap/aws/latest) module available on the Terraform Registry is designed to bootstrap an EKS (Elastic Kubernetes Service) cluster in AWS (Amazon Web Services) with the necessary resources to run a kubernetes workload.

The module provides a simplified and standardized way to create the kubernetes worker nodes in EKS, and to deploy the necessary add-ons and configurations to run kubernetes workloads. It automates the process of creating the necessary EKS resources.

By using this module, AWS users can save time and ensure that their kubernetes workloads are deployed in a consistent and reproducible manner. It also ensures that the EKS cluster is created with the best practices in mind, and that it is secured according to industry standards. The module is open source and maintained by [SquareOps](https://squareops.com/), a consulting company that specializes in cloud infrastructure and DevOps automation.
## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eks_bootstrap"></a> [eks\_bootstrap](#module\_eks\_bootstrap) | squareops/eks-bootstrap/aws | 3.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) | data source |
| [aws_eks_cluster_auth.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster_auth) | data source |
| [terraform_remote_state.eks](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_efs_id"></a> [efs\_id](#output\_efs\_id) | The ID of the EFS |
| <a name="output_istio_ingressgateway_dns_hostname"></a> [istio\_ingressgateway\_dns\_hostname](#output\_istio\_ingressgateway\_dns\_hostname) | DNS hostname of the Istio Ingress Gateway |
| <a name="output_kubeclarity"></a> [kubeclarity](#output\_kubeclarity) | Hostname for the kubeclarity. |
| <a name="output_kubecost"></a> [kubecost](#output\_kubecost) | Hostname for the kubecost. |
| <a name="output_nginx_ingress_controller_dns_hostname"></a> [nginx\_ingress\_controller\_dns\_hostname](#output\_nginx\_ingress\_controller\_dns\_hostname) | NGINX Ingress Controller DNS Hostname |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
