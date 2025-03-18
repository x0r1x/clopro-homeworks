resource "yandex_mdb_mysql_cluster" "mysql_cluster" {
  name        = "mysql-cluster"
  environment = "PRESTABLE"
  version     = "8.0"
  network_id  = yandex_vpc_network.network.id

  resources {
    resource_preset_id = "b1.medium"  # Intel Broadwell с производительностью 50% CPU
    disk_size          = 20           # Размер диска 20 Гб
    disk_type_id       = "network-hdd"
  }

  host {
    zone      = var.yc_zone_a
    subnet_id = yandex_vpc_subnet.private_subnet_a.id
  }

  host {
    zone      = var.yc_zone_b
    subnet_id = yandex_vpc_subnet.private_subnet_b.id
  }

  # maintenance_window {
  #   type = "ANYTIME"
  # }

  maintenance_window {
    type = "WEEKLY"
    day = "SUN"
    hour = 2
  }

  backup_window_start { # Время начала резервного копирования — 23:59
    hours   = 23
    minutes = 59
  }

  deletion_protection = true # Включаем защиту кластера от непреднамеренного удаления
}

# Создание базы данных
resource "yandex_mdb_mysql_database" "netology_db" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = var.yc_mysql_db_name
}

# Создание пользователя
resource "yandex_mdb_mysql_user" "netology_user" {
  cluster_id = yandex_mdb_mysql_cluster.mysql_cluster.id
  name       = var.yc_mysql_user
  password   = var.yc_mysql_user_password
  
  permission {
    database_name = yandex_mdb_mysql_database.netology_db.name
    roles         = ["ALL"]
  }
}