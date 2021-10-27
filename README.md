# AWS EKS Cluster Terraform module

Terraform module which creates EKS Cluster resources on AWS.

These types of resources are supported:

* [EKS Cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
* [CloudWatch Log Group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group)
* [SecurityGroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
* [VPC Endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint)
* [IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role)
* [IAM Role Policy Attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment)


## Usage
### EKS Cluster

main.tf
```hcl
module "eks_cluster" {
  source = "git@github.com:jangjaelee/terraform-aws-eks-cluster.git"

  vpc_name        = local.vpc_name
  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version
  
  cluster_public_access_cidrs = ["0.0.0.0/0"]
  cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"] 
  #kms_arn_eks = "arn:aws:kms:ap-northeast-2:000000000000:key/21d5f9b3-5fc4-43d6-a1d0-3836246327a1"
  kms_arn_eks = ""
  create_endpoint_ecr = true

  private_sub_env1 = "1"
  private_sub_env2 = "2"
  public_sub_env1  = "1"
  public_sub_env2  = "2"

  env = "dev"
}
```

locals.tf
```hcl
locals {
  vpc_name = "KubeSphere-dev"
  cluster_name = "KubeSphere-v121-dev"
  cluster_version = "1.21"
}
```

providers.tf
```hcl
provider "aws" {
  version = ">= 3.2.0"
  region = var.region
  allowed_account_ids = var.account_id
  profile = "eks_service"
}
```

terraform.tf
```hcl
terraform {
  required_version = ">= 0.13.0"

  backend "s3" {
    bucket = "kubesphere-terraform-state-backend"
    key = "kubesphere/eks-cluster/terraform.tfstate"
    region = "ap-northeast-2"
    dynamodb_table = "kubesphere-terraform-state-locks"
    encrypt = true
    profile = "eks_service"
  }
}
```

variables.tf
```hcl
variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-northeast-2"
}

variable "account_id" {
  description = "List of Allowed AWS account IDs"
  type        = list(string)
  default     = ["123456789012"]
}
```
