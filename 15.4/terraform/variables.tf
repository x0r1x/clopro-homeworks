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

variable "yc_zone_a" {
  type        = string
  default     = "ru-central1-a"
  sensitive   = true
}

variable "yc_zone_b" {
  type        = string
  default     = "ru-central1-b"
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

variable "yc_mysql_db_name" {
  type = string
  default = "netology_db"
}

variable "yc_mysql_user" {
  type = string
  default = "netology_user"
}

variable "yc_mysql_user_password" {
  type = string
  sensitive = true
}
