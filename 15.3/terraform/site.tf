locals {
    yc_site = "${var.yc_student}.ru"
    yc_site_key = "index.html"
    yc_site_path = "resources/${local.yc_site_key}"
}

// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "alekeykashin-ru" {
  bucket  = local.yc_site
  acl     = "public-read"

  website {
    index_document = local.yc_site_key
    error_document = "error.html"
  }

  https {
    certificate_id = "fpqti08mkicdjt4v7nmu"
  }

}

// Загрузка объекта
resource "yandex_storage_object" "index_document" {
  bucket     = local.yc_site
  key        = local.yc_site_key 
  source     = local.yc_site_path
  acl        = "public-read"
  depends_on = [yandex_storage_bucket.alekeykashin-ru]

}