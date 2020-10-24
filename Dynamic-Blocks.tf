provider "aws" {

  access_key = "access-key"
  secret_key = "secret-key"
  region     = "us-east-1"
}

locals {
	ingress_rules = [{
		port        = 443
		description = "Port 443"
	},
	{
		port        = 80
		description = "Port 80"
	}]
}

resource "aws_security_group" "SG1" {
	name   = "SG"

  	dynamic "ingress" {
		for_each = local.ingress_rules
    iterator= map_ports

		content {
			description = map_ports.value.description
			from_port   = map_ports.value.port
			to_port     = map_ports.value.port
			protocol    = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}

	tags = {
		Name = "security group"
	}
}
