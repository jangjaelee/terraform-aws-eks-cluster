data "aws_region" "current" {}

data "aws_vpc" "this" {
  filter {
    name   = "tag:Name"
    values = ["${var.vpc_name}-vpc"]
  }
}

data "aws_subnet_ids" "vpce_subnets" {
  vpc_id = data.aws_vpc.this.id

  filter {
    name   = "tag:net:type"
    values = ["private"]
  }

  filter {
    name   = "tag:net:env"
    values = [var.private_sub_env2]
  }
}

data "aws_subnet_ids" "cluster_subnets" {
  vpc_id = data.aws_vpc.this.id
}