resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7

  tags = merge(
    {
      "Name" = format("%s-cwatch-logrp", var.cluster_name)
    },
    local.common_tags,
  )
}