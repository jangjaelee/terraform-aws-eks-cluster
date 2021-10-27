resource "aws_vpc_endpoint" "ecr-dkr" {
  count  = var.create_endpoint_ecr ? 1 : 0

  vpc_id = data.aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.ecr.dkr"
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.vpce.id]
  subnet_ids = data.aws_subnet_ids.vpce_subnets.ids
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.vpc_name}-ecr.dkr-vpce"
    },
    local.common_tags,
  )
}

resource "aws_vpc_endpoint" "ecr-api" {
  count  = var.create_endpoint_ecr ? 1 : 0

  vpc_id = data.aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.ecr.api"
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.vpce.id]
  subnet_ids = data.aws_subnet_ids.vpce_subnets.ids
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.vpc_name}-ecr.api-vpce"
    },
    local.common_tags,
  )
}
