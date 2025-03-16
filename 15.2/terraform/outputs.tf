output "bucket_url" {
  value = "http://${yandex_storage_bucket.bucket.bucket_domain_name}/${yandex_storage_object.image.key}"
}

# Получение информации о ВМ из Instance Group
output "instance_ips" {
  value = [
    for instance in yandex_compute_instance_group.lamp_group.instances : instance.network_interface[0].ip_address
  ]
}

# Вывод адресов балансировщиков
output "alb_external_ip" {
 value = yandex_alb_load_balancer.alb.listener[*].endpoint[*].address[*].external_ipv4_address[*].address
}

output "nlb_external_ip" {
  value = yandex_lb_network_load_balancer.nlb.listener[*].external_address_spec[*].address
}