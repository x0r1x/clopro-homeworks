output "bucket_url" {
  value = "http://${yandex_storage_bucket.bucket.bucket_domain_name}/${yandex_storage_object.image.key}"
}