resource "yandex_kms_symmetric_key" "bucket_key" {
  name              = "bucket-encryption-key"
  description       = "Key for encrypting bucket content"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}