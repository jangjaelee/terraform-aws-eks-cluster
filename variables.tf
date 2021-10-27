variable "vpc_name" {
  description = "Name to be used on all the resources as identifier for VPC"
  type        = string
}

variable "cluster_name" {
  description = "Name for EKS Cluster "
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes Version for EKS Cluster "
  type        = string
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_public_access_cidrs" {
  description = "List of CIDR blocks that can access the Amazon EKS public API"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_log_types" {
  description = "List of control plane logging to enable"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

/*
variable "eks_cluster_subnet_ids" {
  description = "List of subnet IDs for EKS"
  type        = list(string)
}
*/

variable "eks_api_server_ingress_cidr_blocks" {
  description = "CIDR blocks whitelist for EKS api server"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}


variable "vpc_endpoint_subnet_ids" {
  description = "List of subnet IDS for endpoint ENI"
  type        = list(string)
}


variable "default_destination" {
  description = "Default route destnation"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "worker_nodes_remoteAccess" {
  description = "CIDR blocks whitelist for EKS(k8s) worker nodes"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "enable_public_subnet" {
  description = "Indicate whether to create public subnet"
  type        = bool
  default     = true
}

variable "kms_arn_eks" {
  description = "Amazon Resource Name (ARN) of the Key Management Service (KMS) customer master key (CMK)."
  type        = string
}

variable "encryption_resources" {
  description = "List of strings with resources to be encrypted. Valid values: secrets"
  type        = list(string)
  default     = ["secrets"]
}

variable "enable_sub_env" {
  description = "Indicate whether to enable sub-environment"
  type        = bool
  default     = false
}

variable "private_sub_env1" {
  description = "Private Sub-Environment 1"
  type        = string
  default     = ""
}

variable "public_sub_env1" {
  description = "Public Sub-Environment 1"
  type        = string
  default     = ""
}

variable "private_sub_env2" {
  description = "Private Sub-Environment 2"
  type        = string
  default     = ""
}

variable "public_sub_env2" {
  description = "Public Sub-Environment 2"
  type        = string
  default     = ""
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "create_endpoint_ecr" {
  description = "Controls if VPC Endpoint for ECR should be created"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "env" {
  description = "Environment"
  type = string
}
