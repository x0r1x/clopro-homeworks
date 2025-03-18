output "mysql_host" {
  value = yandex_mdb_mysql_cluster.mysql_cluster.host[0].fqdn
}

output "mysql_user" {
  value = yandex_mdb_mysql_user.netology_user.name
}