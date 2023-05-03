locals {
  region      = "us-east-2"
  environment = "prod"
  name        = "skaf"
  additional_aws_tags = {
    Owner      = "SquareOps"
    Expires    = "Never"
    Department = "Engineering"
  }
  vpc_cidr           = "172.10.0.0/16"
  vpn_server_enabled = true
}

module "key_pair_vpn" {
  count              = local.vpn_server_enabled ? 1 : 0
  source             = "squareops/keypair/aws"
  version            = "1.0.2"
  environment        = local.environment
  key_name           = format("%s-%s-vpn", local.environment, local.name)
  ssm_parameter_path = format("%s-%s-vpn", local.environment, local.name)
}

module "vpc" {
  source                                          = "squareops/vpc/aws"
  version                                         = "2.1.0"
  name                                            = local.name
  vpc_cidr                                        = local.vpc_cidr
  environment                                     = local.environment
  flow_log_enabled                                = true
  vpn_key_pair_name                               = local.vpn_server_enabled ? module.key_pair_vpn[0].key_pair_name : null
  vpn_server_enabled                              = local.vpn_server_enabled
  availability_zones                              = 2
  intra_subnet_enabled                            = true
  public_subnet_enabled                           = true
  private_subnet_enabled                          = true
  one_nat_gateway_per_az                          = true
  database_subnet_enabled                         = true
  vpn_server_instance_type                        = "t3a.small"
  flow_log_max_aggregation_interval               = 60
  flow_log_cloudwatch_log_group_retention_in_days = 90
}
