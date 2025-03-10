
# NAT-инстанс
resource "yandex_compute_instance" "nat" {
  name        = "nat-instance"
  platform_id = "standard-v1"
  zone        = var.yc_default_zone

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_image_id
      type     = "network-hdd"
      size     = 5
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.public.id
    ip_address = var.nat_ip_address
    nat        = true
  }

  metadata = {
    ssh-keys = local.ssh_key
  }

  scheduling_policy { preemptible = true }
}

# Публичная ВМ
resource "yandex_compute_instance" "public" {
  name        = "public-vm"
  platform_id = "standard-v1"
  zone        = var.yc_default_zone

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type     = "network-hdd"
      size     = 8
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.public.id
    nat       = true
  }

  metadata = {
    ssh-keys = local.ssh_key
  }

  scheduling_policy { preemptible = true }
}

# Приватная ВМ
resource "yandex_compute_instance" "private" {
  name        = "private-vm"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"

  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-2204-lts.image_id
      type     = "network-hdd"
      size     = 8
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.private.id
  }

  metadata = {
    ssh-keys = local.ssh_key
  }

  scheduling_policy { preemptible = true }
}