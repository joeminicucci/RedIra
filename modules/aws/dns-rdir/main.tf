data "aws_region" "current" {}

resource "random_id" "server" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_key_pair" "dns-rdir" {
  key_name = "dns-rdir-key-${random_id.server.hex}"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "dns-rdir" {
  tags = {
    Name = "dns-rdir-${random_id.server.hex}"
  }

  ami = var.amis[data.aws_region.current.name]
  instance_type = var.instance_type
  key_name = aws_key_pair.dns-rdir.key_name
  vpc_security_group_ids = concat(var.security_groups, [aws_security_group.dns-rdir.id])
  subnet_id = var.subnet_id
  associate_public_ip_address = true

   #this provisioner exists for 2 reasons:
    # 1. To support custom scripts, which ideally should be included in an ansible role/task rather than invoked inline like this.
    # 2. To ensure that SSH is open before Ansible local-exec provisioner attempts its execution
  provisioner "remote-exec" {
    scripts = var.install

    connection {
        type = "ssh"
        user = var.user
        private_key = tls_private_key.ssh.private_key_pem
        host = self.private_ip
    }
  }

  provisioner "local-exec" {
    command = "echo \"${tls_private_key.ssh.private_key_pem}\" > ${local.ssh-keys-path}/${self.private_ip} && echo \"${tls_private_key.ssh.public_key_openssh}\" > ${local.ssh-keys-path}/${self.private_ip}.pub && chmod 600 ${local.ssh-keys-path}/*"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ${path.root}/data/ssh_keys/${self.private_ip}*"
  }

}

data "template_file" "ssh_config" {
  depends_on = [aws_instance.dns-rdir]

  template = file("${local.templates-path}/ssh_config.tpl")
  vars = {
    name = "dns_rdir_${aws_instance.dns-rdir.private_ip}"
    hostname = aws_instance.dns-rdir.private_ip
    user = var.user
    identityfile = "${local.ssh-keys-path}/${aws_instance.dns-rdir.private_ip}"
  }
}

resource "null_resource" "gen_ssh_config" {
  depends_on = [data.template_file.ssh_config]

  triggers = {
    template_rendered = data.template_file.ssh_config.rendered
    serverId = random_id.server.hex
    serverIp = aws_instance.dns-rdir.private_ip
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.ssh_config.rendered}' > ${local.ssh-configs-path}/${self.triggers.serverIp}_config"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ${path.root}/data/ssh_configs/${self.triggers.serverIp}_config"
  }
}

module "dns-rdir-config-ansible"{
  source = "../../ansible/core"
  depends_on = [aws_instance.dns-rdir, null_resource.gen_ssh_config]

  user = var.user
  playbook = local.ansible-config-playbook
  ip = aws_instance.dns-rdir.private_ip
}


module "dns-rdir-ansible"{
  source = "../../ansible/core"
  depends_on = [module.dns-rdir-config-ansible]

  user = var.user
  playbook = local.ansible-rdir-playbook
  arguments = ["--extra-vars 'redirect_to=${var.redirect_to} redirector_type=dns'"]
  ip = aws_instance.dns-rdir.private_ip
}
