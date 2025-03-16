# Создание Instance Group
resource "yandex_compute_instance_group" "lamp_group" {
  name               = "lamp-instance-group"
  service_account_id = var.yc_service_account_id

  instance_template {
    
    platform_id = "standard-v1"
    resources {
        cores  = 2
        memory = 1
        core_fraction = 20
    }

    scheduling_policy {
        preemptible = true  // Прерываемая
    }

    boot_disk {
      initialize_params {
        image_id = var.lamp-instance-image-id
      }
    }

    network_interface {
      network_id         = yandex_vpc_network.network.id
      subnet_ids         = [yandex_vpc_subnet.public_subnet.id]
      nat                = true
      security_group_ids = [yandex_vpc_security_group.lamp_sg.id]
    }

    metadata = {
      ssh-keys   = local.ssh_key
      user-data  = <<-EOF
        #cloud-config
        packages:
          - apache2
          - mysql-server
          - php
          - php-mysql
        runcmd:
          - systemctl enable apache2
          - systemctl start apache2
          - echo "<html><body><h1>Hello World!</h1><img src='https://${yandex_storage_bucket.bucket.bucket_domain_name}/${yandex_storage_object.image.key}'></body></html>" > /var/www/html/index.html
      EOF
    }

    labels = {
      instance_group = "lamp-group"
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.yc_default_zone]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0
  }

  health_check {
    http_options {
      port = 80
      path = "/"
    }
  }
}
