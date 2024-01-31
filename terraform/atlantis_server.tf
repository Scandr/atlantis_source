resource "yandex_compute_instance" "atlantis-server" {
  name                      = "atlantis-server"
  zone                      = "ru-central1-a"
  hostname                  = "atlantis-server.netology.yc"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }
  boot_disk {
    initialize_params {
      image_id    = "${var.os_destrib}"
      name        = "root-atlantis"
      type        = "network-nvme"
      size        = "40"
    }
  }
  network_interface {
    subnet_id  = "${yandex_vpc_subnet.netology-atlantis.id}"
    nat        = true
    ip_address = "192.168.30.3"
  }

  metadata = {
    ssh-keys = "ubuntu:${file("/opt/yandex_cloud/id_rsa.pub")}"
  }
}
