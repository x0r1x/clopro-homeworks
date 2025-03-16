# Создание Target Group
resource "yandex_alb_target_group" "lamp_targets" {
  name = "lamp-targets"

  dynamic "target" {
    for_each = yandex_compute_instance_group.lamp_group.instances
    content {
      subnet_id  = yandex_vpc_subnet.public_subnet.id
      ip_address = target.value.network_interface[0].ip_address
    }
  }

  depends_on = [ yandex_compute_instance_group.lamp_group ]
}

# Создание Backend Group для ALB
resource "yandex_alb_backend_group" "backend_group" {
  name = "backend-group"

  http_backend {
    name             = "http-backend"
    weight           = 1
    port             = 80
    target_group_ids = [yandex_alb_target_group.lamp_targets.id]

    healthcheck {
      timeout  = "10s"
      interval = "2s"

      http_healthcheck {
        path = "/"
      }
    }
  }

  depends_on = [yandex_alb_target_group.lamp_targets] # Явная зависимость
}

# Создание HTTP Router для ALB
resource "yandex_alb_http_router" "router" {
  name = "http-router"
}

# Создание Virtual Host для ALB
resource "yandex_alb_virtual_host" "virtual_host" {
  name           = "virtual-host"
  http_router_id = yandex_alb_http_router.router.id

  route {
    name = "route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.backend_group.id
      }
    }
  }
  depends_on = [yandex_alb_backend_group.backend_group] # Явная зависимость
}

# Создание Application Load Balancer (ALB)
resource "yandex_alb_load_balancer" "alb" {
  name = "application-lb"

  network_id = yandex_vpc_network.network.id

  allocation_policy {
    location {
      zone_id   = var.yc_default_zone
      subnet_id = yandex_vpc_subnet.public_subnet.id
    }
  }

  listener {
    name = "http-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.router.id
      }
    }
  }
  depends_on = [yandex_alb_http_router.router]
}
