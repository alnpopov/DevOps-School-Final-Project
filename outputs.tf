
# generate inventory file for Ansible
resource "local_file" "HostsForAnsible" {
  content = templatefile("hosts.tpl",
    {
      build_servers = aws_instance.build_srv.*.public_ip
      stage_servers = aws_instance.stage_srv.*.public_ip
    }
  )
  filename = "hosts"
}
