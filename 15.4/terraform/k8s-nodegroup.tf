resource "yandex_kubernetes_node_group" "main_nodes" {
  cluster_id = yandex_kubernetes_cluster.netology_k8s.id
  name       = "main-nodegroup"
  version    = "1.29"

  # scale_policy {
  #   auto_scale {
  #     min     = 3
  #     max     = 6
  #     initial = 3
  #   }
  # }

  # scale_policy {
  #   auto_scale {
  #     min     = 1
  #     max     = 3  # Было 6 → стало 3
  #     initial = 1
  #   }
  # }

  scale_policy {
    fixed_scale {
      size = 3 # Фиксированное количество нод
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
    location {
      zone = "ru-central1-b"
    }
    location {
      zone = "ru-central1-d"
    }
  }

  instance_template {
    platform_id = "standard-v2"
    network_interface {
      subnet_ids = [
        yandex_vpc_subnet.public_k8s_a.id,
        yandex_vpc_subnet.public_k8s_b.id,
        yandex_vpc_subnet.public_k8s_d.id
      ]
      nat = true
    }

    resources {
      cores  = 2
      memory = 4
    }

    boot_disk {
      type = "network-hdd"
      size = 30
    }
  }
}