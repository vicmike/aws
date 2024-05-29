variable "region" {
  description = "The AWS region to deploy in"
  default     = "ca-central-1"
}

variable "aws_profile" {
  description = "The AWS profile to use"
  default     = "gs"
}


variable "instance_type" {
  description = "Instance type to deploy"
  default     = "t3a.medium"
  # Free tier eligable arm instance
  #default     = "t4g.nano"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  # Ubuntu 22.04 AMD64
  default     = "ami-0bb0ed6088d3b1bec"
  # Ununtu 22.04 ARM
  #default         = "ami-0b0d2abef64746350"
  # aws linux 2023 arm
  #default         = "ami-0b0d2abef64746350"
}

variable "key_name" {
  description = "The SSH key name"
  default     = "mikew-1pass"
}

variable "user_name" {
  description = "The name of the user to create on the instance"
  default     = "mikew"
}

variable "github_user" {
  description = "The Github user to copy ssh keys from"
  default     = "vicmike"
}

variable "instance_name" {
  description = "The instance name"
  default     = "dev-server"
}

variable "hostname" {
  description = "The hostname to set for the instance"
  default     = "dev-server"
}

variable "project_id" {
  description = "Project name for billing purposes"
  default     = "Development server"
}

