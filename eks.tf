module "key_pair_eks" {
  source             = "squareops/keypair/aws"
  version            = "1.0.2"
  key_name           = format("%s-%s-eks", local.environment, local.name)
  environment        = local.environment
  ssm_parameter_path = format("%s-%s-eks", local.environment, local.name)
}

module "eks" {
  source                               = "squareops/eks/aws"
  depends_on                           = [module.vpc]
  version                              = "3.1.0"
  name                                 = local.name
  vpc_id                               = module.vpc.vpc_id
  environment                          = local.environment
  cluster_version                      = "1.26"
  kms_key_arn                          = "arn:aws:kms:us-east-2:271251951598:key/d7485321-ad5a-4e13-8dfa-3552c7c2c256"
  cluster_log_types                    = ["api", "scheduler"]
  private_subnet_ids                   = module.vpc.private_subnets
  cluster_log_retention_in_days        = 30
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  create_aws_auth_configmap            = true
  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::271251951598:user/ankur-aws-skaf"
      username = "ankur-aws-skaf"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::271251951598:user/aditya-aws-skaf"
      username = "aditya-aws-skaf"
      groups   = ["system:masters"]
    }
  ]
}

# data "aws_eks_cluster" "cluster" {
#   depends_on  = [ module.eks ]
#   name = module.eks.cluster_name
# }

# data "aws_eks_cluster_auth" "cluster" {
#   depends_on  = [ module.eks ]
#   name = module.eks.cluster_name
# }

module "managed_node_group_production" {
  source                 = "squareops/eks/aws//modules/managed-nodegroup"
  version                = "3.1.0"
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
  kms_key_arn            = "arn:aws:kms:us-east-2:271251951598:key/d7485321-ad5a-4e13-8dfa-3552c7c2c256"
  k8s_labels = {
    "Infra-Services" = "true"
  }
  tags = local.additional_aws_tags
}
