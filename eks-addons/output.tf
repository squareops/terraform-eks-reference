output "nginx_ingress_controller_dns_hostname" {
  description = "NGINX Ingress Controller DNS Hostname"
  value       = module.eks_bootstrap.nginx_ingress_controller_dns_hostname
}

output "efs_id" {
  value       = module.eks_bootstrap.efs_id
  description = "The ID of the EFS"
}

output "kubeclarity" {
  value       = module.eks_bootstrap.kubeclarity
  description = "Hostname for the kubeclarity."
}

output "kubecost" {
  value       = module.eks_bootstrap.kubecost
  description = "Hostname for the kubecost."
}

output "istio_ingressgateway_dns_hostname" {
  value       = module.eks_bootstrap.istio_ingressgateway_dns_hostname
  description = "DNS hostname of the Istio Ingress Gateway"
}
