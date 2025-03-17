locals {
    yc_bucket_name = "${var.yc_student}-${formatdate("YYYY-MM-DD", timestamp())}"
    yc_image = "image.png"
    yc_image_path = "resources/${local.yc_image}"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "bucket" {
  bucket = local.yc_bucket_name
  acl    = "public-read"

    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.bucket_key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}


resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = local.yc_image
  source = local.yc_image_path
  acl    = "public-read"
  depends_on = [yandex_storage_bucket.bucket]
}


