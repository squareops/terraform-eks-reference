locals {
  region      = "us-east-2"
  environment = "prod"
  name        = "skaf"
  additional_aws_tags = {
    Owner      = "organization_name"
    Expires    = "Never"
    Department = "Engineering"
  }
  ipv6_enabled = true
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    region = "us-east-2"
    bucket = "eks-ref-bucket"
    key    = "eks/terraform.tfstate"
  }
}

data "aws_eks_cluster" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_name
}

module "eks_bootstrap" {
  source                                        = "squareops/eks-bootstrap/aws"
  version                                       = "3.1.1"
  name                                          = local.name
  environment                                   = local.environment
  eks_cluster_name                              = data.terraform_remote_state.eks.outputs.cluster_name
  vpc_id                                        = data.terraform_remote_state.eks.outputs.vpc_id
  ipv6_enabled                                  = local.ipv6_enabled
  kms_key_arn                                   = ""
  worker_iam_role_name                          = data.terraform_remote_state.eks.outputs.worker_iam_role_name
  worker_iam_role_arn                           = data.terraform_remote_state.eks.outputs.worker_iam_role_arn
  kms_policy_arn                                = data.terraform_remote_state.eks.outputs.kms_policy_arn # eks module will create kms_policy_arn
  keda_enabled                                  = true
  reloader_enabled                              = true
  private_subnet_ids                            = data.terraform_remote_state.eks.outputs.private_subnets
  metrics_server_enabled                        = true
  external_secrets_enabled                      = true
  amazon_eks_vpc_cni_enabled                    = true
  service_monitor_crd_enabled                   = true
  cert_manager_enabled                          = true
  cert_manager_letsencrypt_email                = "admin@example.com"
  cert_manager_install_letsencrypt_http_issuers = true
  ingress_nginx_enabled                         = true
  internal_ingress_nginx_enabled                = true
  efs_storage_class_enabled                     = true
  single_az_sc_config                           = [{ name = "infra-service-sc", zone = "us-east-2a" }]
  kubeclarity_enabled                           = true
  kubeclarity_hostname                          = "kubeclarity.squareops.in"
  kubecost_enabled                              = true
  kubecost_hostname                             = "kubecost.squareops.in"
  amazon_eks_aws_ebs_csi_driver_enabled         = true
  single_az_ebs_gp3_storage_class_enabled       = true
  cluster_autoscaler_enabled                    = true
  cluster_propotional_autoscaler_enabled        = true
  aws_node_termination_handler_enabled          = true
  karpenter_enabled                             = true
  enable_aws_load_balancer_controller           = true
  istio_enabled                                 = true
  istio_config = {
    ingress_gateway_enabled             = true
    ingress_gateway_namespace           = "istio-ingressgateway"
    egress_gateway_enabled              = true
    egress_gateway_namespace            = "istio-egressgateway"
    observability_enabled               = true
    envoy_access_logs_enabled           = true
    prometheus_monitoring_enabled       = true
    cert_manager_cluster_issuer_enabled = true
  }
  karpenter_provisioner_enabled = true
  karpenter_provisioner_config = {
    private_subnet_name    = format("%s-%s-private-subnet", local.environment, local.name)
    instance_capacity_type = ["spot"]
    excluded_instance_type = ["nano", "micro", "small"]
    instance_hypervisor    = ["nitro"]
  }
  velero_enabled = false
  velero_config = {
    namespaces                      = "" # If you want full cluster backup, leave it blank else provide namespace.
    slack_notification_token        = "4559734786594"
    slack_notification_channel_name = "demo-notifications"
    retention_period_in_days        = 45
    schedule_backup_cron_time       = "* 1 * * *"
    velero_backup_name              = "clusterbackup"
    backup_bucket_name              = "velero-backup"
  }

}
