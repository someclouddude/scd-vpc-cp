variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of public subnet CIDRs"
  default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of private subnet CIDRs"
  default     = ["10.0.48.0/20", "10.0.64.0/20", "10.0.80.0/20"]
}

variable "k8s_subnet_cidrs" {
  type        = list(string)
  description = "List of k8s subnet CIDRs"
  default     = ["10.0.96.0/20", "10.0.112.0/20", "10.0.128.0/20"]
}

variable "nat_instance_type" {
  type        = string
  description = "Instance type for NAT instances (ARM-based)"
  default     = "t4g.small"
}

variable "nat_ami_id" {
  type        = string
  description = "AMI ID for NAT instance (ARM-based, Amazon Linux 2 or similar)"
  default     = "ami-0c02fb55956c7d316" # Update as needed for your region
}
