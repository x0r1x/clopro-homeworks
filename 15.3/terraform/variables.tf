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
}

variable "yc_service_account_id" {
  type = string
  sensitive = true
}

variable "yc_student" {
  type        = string
  default     = "alekseykashin"
  sensitive   = true
}

variable "yc_public_v4_cidr_blocks" {
  type        = list(string)
  default     = ["192.168.10.0/24"]
}

variable "lamp-instance-image-id" {
  type = string
  default = "fd827b91d99psvq5fjit"
}
