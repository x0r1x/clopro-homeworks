variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
  sensitive   = true
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
  sensitive   = true
}

variable "yc_default_zone" {
  type        = string
  default     = "ru-central1-a"
  sensitive   = true
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "ssh_public_key" {
  description = "SSH public key for instances"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

########
variable "yc_private_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.20.0/24"]
}

variable "yc_public_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
}

variable "nat_image_id" {
  type = string
  default = "fd80mrhj8fl2oe87o4e1"
}

variable "nat_ip_address" {
  type = string
  default = "192.168.10.254"
}