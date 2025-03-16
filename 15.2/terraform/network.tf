# Создание сети и подсети
resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public-subnet"
  zone           = var.yc_default_zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = var.yc_public_v4_cidr_blocks
}

# Создание Security Group для HTTP-трафика
resource "yandex_vpc_security_group" "lamp_sg" {
  name        = "lamp-security-group"
  network_id  = yandex_vpc_network.network.id

  ingress {
    protocol       = "TCP"
    description    = "HTTP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "Outgoing traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
