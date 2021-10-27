resource "aws_iam_role" "this" {
  name_prefix = "eksClusterRole_"
  path = "/${var.cluster_name}/"
  description = "The role that Amazon EKS will use to interact AWS resources for Kubernetes clusters"
  assume_role_policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  POLICY

  tags = merge(
    {
      "Name" = format("%s-iam-role", var.cluster_name)      
    },
    local.common_tags,
  )
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = toset(["AmazonEKSClusterPolicy", "AmazonEKSServicePolicy"])
  policy_arn = "arn:aws:iam::aws:policy/${each.value}"
  role = aws_iam_role.this.name
}