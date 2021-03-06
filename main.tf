
provider "aws" {
  region = "eu-west-2"
}

data "aws_availability_zones" "available" {}
locals {
  cluster_name = "ao-task-${random_string.suffix.result}"
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}

#VPC


module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "ao-task-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }

}

#SECURITY-GROUPS

resource "aws_security_group" "ao_task_worker_group_mgmt_one" {
  name_prefix = "ao_task_worker_group_mgmt_one"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }

}
resource "aws_security_group" "ao_task_worker_group_mgmt_two" {
  name_prefix = "ao_task_worker_group_mgmt_two"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "192.168.0.0/16",
    ]
  }
}

resource "aws_security_group" "ao_task_worker_group_mgmt_three" {
  name_prefix = "ao_task_worker_group_mgmt_three"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      "10.0.0.0/8",
      "172.16.0.0/12",
      "192.168.0.0/16",
    ]
  }
}






