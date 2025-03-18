resource "yandex_kubernetes_cluster" "netology_k8s" {
  name        = "netology-k8s-cluster"
  network_id  = yandex_vpc_network.network.id
  cluster_ipv4_range = "10.1.0.0/16"
  service_ipv4_range = "10.2.0.0/16"

  master {
    regional {
      region = "ru-central1"
      location {
        zone      = "ru-central1-a"
        subnet_id = yandex_vpc_subnet.public_k8s_a.id
      }
      location {
        zone      = "ru-central1-b"
        subnet_id = yandex_vpc_subnet.public_k8s_b.id
      }
      location {
        zone      = "ru-central1-d"
        subnet_id = yandex_vpc_subnet.public_k8s_d.id
      }
    }
    version   = "1.29"
    public_ip = true
  }

  service_account_id      = var.yc_service_account_id
  node_service_account_id = var.yc_service_account_id

  kms_provider {
    key_id = yandex_kms_symmetric_key.k8s_key.id
  }

  depends_on = [
    yandex_vpc_subnet.public_k8s_a,
    yandex_vpc_subnet.public_k8s_b,
    yandex_vpc_subnet.public_k8s_d
  ]
}
