# Cчитываем данные об образе ОС
data "yandex_compute_image" "ubuntu-2204-lts" {
  family = "ubuntu-2204-lts"
}