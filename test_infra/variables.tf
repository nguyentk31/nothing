variable "env" {
  type = string
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

# ECR module's variables
variable "github_account_id" {
  type        = string
  default     = "992382851936"
  description = "Github account id"
}
