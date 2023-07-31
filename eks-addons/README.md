# eks-bootstrap

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

Prerequisite to deploy vpc and eks for eks-bootstrap deployement.

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
