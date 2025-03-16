# Создание Target Group
resource "yandex_lb_target_group" "lamp_targets" {
  name      = "lamp-targets"

  dynamic "target" {
    for_each = yandex_compute_instance_group.lamp_group.instances
    content {
      subnet_id = yandex_vpc_subnet.public_subnet.id
      address   = target.value.network_interface[0].ip_address
    }
  }

  depends_on = [ yandex_compute_instance_group.lamp_group ]
}

# Создание Network Load Balancer (NLB)
resource "yandex_lb_network_load_balancer" "nlb" {
  name = "network-lb"

  listener {
    name = "http-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.lamp_targets.id

    healthcheck {
      name = "http-healthcheck"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}