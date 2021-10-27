resource "aws_security_group" "vpce" {
  name_prefix = "${var.cluster_name}-VPCE-"
  description = "VPC endpoints communication"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.default_destination
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.default_destination
  }

  tags = merge(
    {
      "Name" = format("%s-vpce-sg", var.cluster_name)
    },
    local.common_tags,
  )
}

resource "aws_security_group" "this" {
  name_prefix = "${var.cluster_name}-Control_Plane-"
  description = "EKS cluster communication"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "Allow communication to EKS API Server"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.eks_api_server_ingress_cidr_blocks
  }

  egress {
    description = "Cluster communication with worker nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.default_destination
  }

  tags = merge(
    {
      "Name" = format("%s-Control_Plane-sg", var.cluster_name)
    },
    local.common_tags,
  )
}

resource "aws_security_group" "eks_remote_access" {
  name_prefix = "${var.cluster_name}-remoteAccess-"
  description = "EKS communication for nodes"
  vpc_id      = data.aws_vpc.this.id

  ingress {
    description = "Allow communication to nodes"  
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.worker_nodes_remoteAccess
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.default_destination
  }

  tags = merge(
    {
      "Name" = format("%s-remoteAccess-sg", var.cluster_name)
    },
    local.common_tags,
  )
}
