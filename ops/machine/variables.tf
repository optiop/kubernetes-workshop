variable "region" {
  type = string
  default = "me-central1"
  description = "The region where the resources will be created"
}

variable "zone" {
  type = string
  default = "me-central1-a"
  description = "The zone where the resources will be created"
}

variable "instance_size" {
  type = string
  default = "n2-standard-4"
  description = "The size of the instance"
}

variable "ssh_keys" {
  type = list(object({
    user = string
    ssh_key  = string
  }))
  description = "List of ssh keys to be added to the instance metadata"
  default = []
}

variable "ssh_pub_key_file" {
  type = string
  default = "~/.ssh/id_rsa.pub"
  description = "The ssh public key file"
} 
