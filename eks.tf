module "key_pair_eks" {
  source             = "squareops/keypair/aws"
  version            = "1.0.2"
  key_name           = format("%s-%s-eks", local.environment, local.name)
  environment        = local.environment
  ssm_parameter_path = format("%s-%s-eks", local.environment, local.name)
}

module "eks" {
  source                               = "squareops/eks/aws"
  version                              = "1.0.3"
  name                                 = local.name
  vpc_id                               = module.vpc.vpc_id
  environment                          = local.environment
  cluster_version                      = "1.24"
  kms_key_arn                          = ""
  cluster_log_types                    = ["api", "scheduler"]
  cluster_log_retention_in_days        = 30
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

module "managed_node_group_production" {
  source                 = "squareops/eks/aws//modules/managed-nodegroup"
  version                = "1.0.3"
  depends_on             = [module.vpc, module.eks]
  name                   = "Infra"
  environment            = local.environment
  eks_cluster_name       = module.eks.cluster_name
  eks_nodes_keypair_name = module.key_pair_eks.key_pair_name
  subnet_ids             = [module.vpc.private_subnets[0]]
  kms_policy_arn         = module.eks.kms_policy_arn
  worker_iam_role_name   = module.eks.worker_iam_role_name
  min_size               = 1
  max_size               = 3
  desired_size           = 1
  capacity_type          = "SPOT"
  instance_types         = ["t3a.large", "t2.large", "t2.xlarge", "t3.large", "m5.large"]
  kms_key_arn            = ""
  k8s_labels = {
    "Infra-Services" = "true"
  }
  tags = local.additional_aws_tags
}



module "eks_bootstrap" {
  source                                        = "squareops/eks-bootstrap/aws"
  version                                       = "1.1.0"
  name                                          = local.name
  environment                                   = local.environment
  eks_cluster_name                              = module.eks.cluster_name
  vpc_id                                        = module.vpc.vpc_id
  kms_key_arn                                   = ""
  worker_iam_role_name                          = module.eks.worker_iam_role_name
  kms_policy_arn                                = module.eks.kms_policy_arn # eks module will create kms_policy_arn
  keda_enabled                                  = true
  istio_enabled                                 = false
  reloader_enabled                              = true
  metrics_server_enabled                        = false
  external_secrets_enabled                      = true
  amazon_eks_vpc_cni_enabled                    = true
  service_monitor_crd_enabled                   = true
  cert_manager_enabled                          = true
  cert_manager_letsencrypt_email                = "admin@example.com"
  cert_manager_install_letsencrypt_http_issuers = true
  ingress_nginx_enabled                         = true
  internal_ingress_nginx_enabled                = true
  efs_storage_class_enabled                     = false
  single_az_sc_config                           = [{ name = "infra-service-sc", zone = "us-east-2a" }]
  amazon_eks_aws_ebs_csi_driver_enabled         = true
  single_az_ebs_gp3_storage_class_enabled       = true
  cluster_autoscaler_enabled                    = true
  cluster_propotional_autoscaler_enabled        = true
  aws_node_termination_handler_enabled          = true
  karpenter_enabled                             = true
  karpenter_provisioner_enabled                 = false
  karpenter_provisioner_config = {
    private_subnet_name    = format("%s-%s-private-subnet", local.environment, local.name)
    instance_capacity_type = ["spot"]
    excluded_instance_type = ["nano", "micro", "small"]
  }
  velero_enabled = true
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
