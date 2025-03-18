resource "yandex_kms_symmetric_key" "k8s_key" {
  name              = "k8s-key"
  description       = "Key for encrypting bucket content"
  default_algorithm = "AES_256"
  rotation_period   = "8760h" # 1 год
}