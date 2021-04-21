resource "aws_security_group" "dns-rdir" {
  tags = {
    Name = "red-team-dns-rdir-${random_id.server.hex}"
  }
  name = "red-team-dns-rdir-${random_id.server.hex}"
  description = "Red Team Infra - DNS C2 Redirector"
  vpc_id = var.vpc_id

  ingress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 53
    to_port = 53
    protocol = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
