output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "AWS Region"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "database_subnets" {
  description = "List of IDs of database subnets"
  value       = module.vpc.database_subnets
}

output "intra_subnets" {
  description = "List of IDs of Intra subnets"
  value       = module.vpc.intra_subnets
}

output "vpn_host_public_ip" {
  description = "IP Adress of VPN Server"
  value       = module.vpc.vpn_host_public_ip
}

output "vpn_security_group" {
  description = "Security Group ID of VPN Server"
  value       = module.vpc.vpn_security_group
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Security group ids attached to the cluster control plane"
  value       = module.eks.cluster_security_group_id
}

output "cluster_arn" {
  description = "Name of the kubeconfig context"
  value       = module.eks.cluster_arn
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster for the OpenID Connect identity provider"
  value       = module.eks.cluster_oidc_issuer_url
}

output "worker_iam_role_arn" {
  description = "ARN of the EKS Worker Role"
  value       = module.eks.worker_iam_role_arn
}

output "worker_iam_role_name" {
  description = "The name of the EKS Worker IAM role"
  value       = module.eks.worker_iam_role_name
}

output "kms_policy_arn" {
  description = "ARN of KMS policy"
  value       = module.eks.kms_policy_arn
}

output "nginx_ingress_controller_dns_hostname" {
  description = "NGINX Ingress Controller DNS Hostname"
  value       = module.eks_bootstrap.nginx_ingress_controller_dns_hostname
}

output "ebs_encryption" {
  description = "Is AWS EBS encryption is enabled or not?"
  value       = "Encrypted by default"
}

output "efs_id" {
  value       = module.eks_bootstrap.efs_id
  description = "EFS ID"
}