# Author: Moises Tapia
# Instance

resource "aws_security_group" "webserver_sg" {

    name    = "Terraform-Server"

    ingress {
        from_port   = var.http_port
        to_port     = var.http_port
        protocol    = var.protocol
        cidr_blocks = ["201.141.44.213/32"]
    }

    ingress {
        from_port   = var.ssh_port
        to_port     = var.ssh_port
        protocol    = var.protocol
        cidr_blocks = ["201.141.44.213/32"]
    }

    egress {

        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}