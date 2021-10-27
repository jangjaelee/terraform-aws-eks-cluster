resource "aws_vpc_endpoint" "vpce" {
  count  = var.create_endpoint_ecr ? 1 : 0

  for_each = toset(["ecr.dkr", "ecr.api"])
  vpc_id = data.aws_vpc.this.id
  service_name = "com.amazonaws.${data.aws_region.current.name}.${each.value}"
  vpc_endpoint_type = "Interface"

  security_group_ids = [aws_security_group.vpce.id]
  subnet_ids = data.aws_subnet_ids.vpce_subnets.ids
  private_dns_enabled = true

  tags = merge(
    {
      Name = "${var.cluster_name}-${each.value}-vpce"
    },
    local.common_tags,
  )
}
