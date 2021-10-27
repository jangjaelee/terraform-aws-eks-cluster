resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.this.arn

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_public_access_cidrs
    security_group_ids      = [aws_security_group.this.id]
    subnet_ids              = data.aws_subnet_ids.cluster_subnets.ids
  }

  enabled_cluster_log_types = var.cluster_log_types

  timeouts {
    create = "30m"
    update = "30m"
    delete = "20m"
  }
  
  encryption_config {
    provider {
      key_arn = var.kms_arn_eks
    }
    resources = var.encryption_resources
  }

  depends_on = [
    aws_iam_role_policy_attachment.this,
    aws_cloudwatch_log_group.this
  ]

  tags = merge(
    {
      "Name" = format("%s-eks-cluster", var.cluster_name)      
    },
    local.common_tags,
  )
}