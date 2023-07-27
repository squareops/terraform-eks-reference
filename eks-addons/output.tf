output "nginx_ingress_controller_dns_hostname" {
  description = "NGINX Ingress Controller DNS Hostname"
  value       = module.eks_bootstrap.nginx_ingress_controller_dns_hostname
}

output "efs_id" {
  value       = module.eks_bootstrap.efs_id
  description = "The ID of the EFS"
}
