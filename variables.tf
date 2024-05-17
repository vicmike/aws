variable "region" {
  description = "The AWS region to deploy in"
  default     = "ca-central-1"
}

variable "instance_type" {
  description = "Instance type to deploy"
  default     = "t2.micro"
  # Free tier eligable arm instance
  #default     = "t4g.nano"
}

variable "ami" {
  description = "The AMI ID to use for the instance"
  # Ubuntu 22.04 AMD64
  default     = "ami-0bb0ed6088d3b1bec"
  # Ununtu 22.04 ARM
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
  default     = "mikew"
}

variable "instance_name" {
  description = "The instance name"
  default     = "dev-server"
}

