locals {
    yc_user = "alekseykashin"
    yc_bucket_name = "${local.yc_user}1244-${formatdate("YYYY-MM-DD", timestamp())}"
    yc_image = "image.png"
    yc_image_path = "resources/${local.yc_image}"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "bucket" {
  bucket = local.yc_bucket_name
  acl    = "public-read"
}


resource "yandex_storage_object" "image" {
  bucket = yandex_storage_bucket.bucket.bucket
  key    = local.yc_image
  source = local.yc_image_path
  acl    = "public-read"
  depends_on = [yandex_storage_bucket.bucket]
}