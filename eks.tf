module "key_pair_eks" {
  source             = "squareops/keypair/aws"
  version            = "1.0.1"
  environment        = local.environment
  key_name           = format("%s-%s-eks", local.environment, local.name)
  ssm_parameter_path = format("%s-%s-eks", local.environment, local.name)
}

module "eks" {
  source                               = "squareops/eks/aws"
  version                              = "1.0.2"
  environment                          = local.environment
  name                                 = local.name
  cluster_enabled_log_types            = ["api", "scheduler"]
  cluster_version                      = "1.23"
  cluster_log_retention_in_days        = 30
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  vpc_id                               = module.vpc.vpc_id
  private_subnet_ids                   = module.vpc.private_subnets
  kms_key_arn                          = "arn:aws:kms:us-east-2:271251951598:key/7fa600be-9c08-4502-a67a-ed7e8bc332cb"
}

module "managed_node_group_production" {
  source               = "squareops/eks/aws//modules/managed-nodegroup"
  version              = "1.0.2"
  name                 = "Infra"
  environment          = local.environment
  eks_cluster_name     = module.eks.cluster_name
  eks_nodes_keypair    = module.key_pair_eks.key_pair_name
  subnet_ids           = [module.vpc.private_subnets[0]]
  worker_iam_role_arn  = module.eks.worker_iam_role_arn
  worker_iam_role_name = module.eks.worker_iam_role_name
  kms_key_arn          = "arn:aws:kms:us-east-2:271251951598:key/7fa600be-9c08-4502-a67a-ed7e8bc332cb"
  kms_policy_arn       = module.eks.kms_policy_arn
  desired_size         = 1
  max_size             = 3
  instance_types       = ["t3a.xlarge"]
  capacity_type        = "ON_DEMAND"
  k8s_labels = {
    "Infra-Services" = "true"
  }
  tags = local.additional_aws_tags
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_name
}

module "eks_bootstrap" {
  depends_on                                    = [module.managed_node_group_production]
  source                                        = "squareops/eks-bootstrap/aws"
  version                                       = "1.0.1"
  environment                                   = local.environment
  name                                          = local.name
  eks_cluster_name                              = "prod-skaf"
  single_az_sc_config                           = [{ name = "infra-service-sc", zone = "us-east-2a" }]
  kms_key_arn                                   = "arn:aws:kms:us-east-2:271251951598:key/7fa600be-9c08-4502-a67a-ed7e8bc332cb"
  kms_policy_arn                                = module.eks.kms_policy_arn
  cert_manager_letsencrypt_email                = "email@example.com"
  vpc_id                                        = module.vpc.vpc_id
  private_subnet_ids                            = module.vpc.private_subnets
  provider_url                                  = module.eks.cluster_oidc_issuer_url
  enable_single_az_ebs_gp3_storage_class        = true
  enable_amazon_eks_aws_ebs_csi_driver          = true
  enable_amazon_eks_vpc_cni                     = true
  create_service_monitor_crd                    = true
  enable_cluster_autoscaler                     = true
  enable_cluster_propotional_autoscaler         = true
  enable_reloader                               = true
  enable_metrics_server                         = true
  enable_ingress_nginx                          = true
  cert_manager_enabled                          = true
  cert_manager_install_letsencrypt_http_issuers = true
  enable_external_secrets                       = true
  enable_keda                                   = true
  create_efs_storage_class                      = true
  enable_istio                                  = false
  enable_karpenter                              = true
  enable_aws_node_termination_handler           = true
  worker_iam_role_name                          = module.eks.worker_iam_role_name
  private_subnet_name                           = format("%s-%s-private-subnet", local.environment, local.name)
  karpenter_ec2_capacity_type                   = ["spot"]
  excluded_karpenter_ec2_instance_type          = ["nano", "micro", "small"]
  velero_config = {
    enable_velero            = false
    slack_token              = "abcd-xyzuWRLN9ug3FTpaOqa7skaf"
    slack_channel_name       = "skaf-notifications"
    retention_period_in_days = 45
    namespaces               = ""
    schedule_cron_time       = "* 1 * * *"
    velero_backup_name       = "clusterback"
    backup_bucket_name       = "msa-base-skaf-test-backup"
  }
}
