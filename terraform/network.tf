# Network
resource "yandex_vpc_network" "atlantis-net" {
  name = "atlantis-net"
}

resource "yandex_vpc_subnet" "netology-atlantis" {
  name = "netology-atlantis"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.atlantis-net.id}"
  v4_cidr_blocks = ["192.168.30.0/28"]
}

