data "aws_region" "current" {}

resource "random_id" "server" {
  byte_length = 4
}

resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "phishing-server" {
  key_name = "phishing-server-key-${random_id.server.hex}"
  public_key = tls_private_key.ssh.public_key_openssh
}

resource "aws_instance" "phishing-server" {
  tags = {
    Name = "phishing-server-${random_id.server.hex}"
  }

  ami = var.amis[data.aws_region.current.name]
  instance_type = var.instance_type
  key_name = aws_key_pair.phishing-server.key_name
  vpc_security_group_ids = var.security_groups
  subnet_id = var.subnet_id
  associate_public_ip_address = false
  #security_groups = []

    provisioner "remote-exec" {
    scripts = var.install

    connection {
        host = self.private_ip
        type = "ssh"
        user = var.user
        private_key = tls_private_key.ssh.private_key_pem
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
     echo "${tls_private_key.ssh.private_key_pem}" > ${local.ssh-keys-path}/${self.private_ip}
     echo "${tls_private_key.ssh.public_key_openssh}" > ${local.ssh-keys-path}/${self.private_ip}.pub
     chmod 600 ${local.ssh-keys-path}/*
    EOT
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ${path.root}/data/ssh_keys/${self.private_ip}* && rm ${path.root}/data/credentials/gophish_*_${self.private_ip}"
  }

}

module "gophish-ansible" {
  source = "../../ansible/gophish"
  depends_on = [aws_instance.phishing-server]


  ansible-user = var.user
  ip = aws_instance.phishing-server.private_ip
  gophish-domain = var.domain
}

data "template_file" "ssh_config" {
  depends_on = [aws_instance.phishing-server]
  template = file("${local.templates-path}/ssh_config.tpl")

  vars  = {
    name = "phishing_${aws_instance.phishing-server.private_ip}"
    hostname = aws_instance.phishing-server.private_ip
    user = var.user
    identityfile = "${path.root}/data/ssh_keys/${aws_instance.phishing-server.private_ip}"
  }

}

resource "null_resource" "gen_ssh_config" {
  depends_on = [data.template_file.ssh_config]

  triggers = {
    template_rendered = data.template_file.ssh_config.rendered
    serverId = random_id.server.hex
    serverIp = aws_instance.phishing-server.private_ip
  }

  provisioner "local-exec" {
    command = "echo '${data.template_file.ssh_config.rendered}' > ${local.ssh-configs-path}/${self.triggers.serverIp}_config"
  }

  provisioner "local-exec" {
    when = destroy
    command = "rm ${path.root}/data/ssh_configs/${self.triggers.serverIp}_config"
  }

}

data "local_file" "gophish-credentials-username" {
  depends_on = [aws_instance.phishing-server, module.gophish-ansible]

  filename = "${local.credentials-path}/gophish_username_${aws_instance.phishing-server.private_ip}"
}

data "local_file" "gophish-credentials-password" {
  depends_on = [aws_instance.phishing-server, module.gophish-ansible]

  filename = "${local.credentials-path}/gophish_password_${aws_instance.phishing-server.private_ip}"
}
