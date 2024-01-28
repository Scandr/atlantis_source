resource "local_file" "inventory" {
  content = <<-DOC
    # Ansible inventory containing variable values from Terraform.
    # Generated by Terraform.
    [all]
    node0 ansible_host=${yandex_compute_instance.atlantis-server.network_interface.0.nat_ip_address} ip=${yandex_compute_instance.atlantis-server.network_interface.0.ip_address}

    [all:vars]
    ansible_user=ubuntu

    DOC
  filename = "../playbooks/inventory.yml"

  depends_on = [
    yandex_compute_instance.atlantis-server
  ]
}
