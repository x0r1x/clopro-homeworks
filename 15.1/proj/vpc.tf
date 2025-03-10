resource "yandex_vpc_network" "main" {
  name = "main-network"
}

# Публичная подсеть
resource "yandex_vpc_subnet" "public" {
  name           = "public"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = var.yc_public_v4_cidr_blocks
  zone           = var.yc_default_zone
}

# Таблица маршрутизации для приватной подсети
resource "yandex_vpc_route_table" "private" {
  network_id = yandex_vpc_network.main.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.nat_ip_address
  }
}

# Приватная подсеть
resource "yandex_vpc_subnet" "private" {
  name           = "private"
  network_id     = yandex_vpc_network.main.id
  v4_cidr_blocks = var.yc_private_v4_cidr_blocks
  zone           = var.yc_default_zone
  route_table_id = yandex_vpc_route_table.private.id
}