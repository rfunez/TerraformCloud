data "aws_ami" "ami_instancias" {
  name_regex = "AMIPublica"
  owners = ["self"]
}

resource "aws_security_group" "sg_espana" {
  vpc_id = aws_vpc.mi_vpc.id
  dynamic "ingress" {
    for_each = var.reglas_fw_publica
    iterator = ingress_rule
    content {
      from_port = ingress_rule.value.puerto
      to_port = ingress_rule.value.puerto
      protocol = ingress_rule.value.protocolo
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = var.reglas_fw_publica
    iterator = egress_rule
    content {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "SG_Espana"
    entorno = "terraform"
  }
}

resource "aws_instance" "instancia_publica" {
  ami = data.aws_ami.ami_instancias.id
  subnet_id = aws_subnet.subnet_publica[0].id
  vpc_security_group_ids = [aws_security_group.sg_espana.id]
  instance_type = var.tipo_instancia_publica
  key_name = aws_key_pair.clave_publica.key_name
  tags = {
    Name = "InstanciaPublica"
    entorno = "terraform"
  }
}

resource "aws_key_pair" "clave_publica" {
  key_name = "PublicKey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDZTEaIQHJMSAo2hK04dERI7kt/76aplAZBJMagNynr2mFfamKN4e29gBWYwPS8YaNkFyjqoO6TYoHqWpWckWXrXbmfkExdMdeqyVu2pC0wFYbMUT/mj60hp/oQfRBG2XIpKlSfzqfhz5iVwjewtjAQOFpAnllrJiEO/K4sUCKKRXErJR04rMKmjTo7b+cgO3oFXEKsC27dHXWlNWNG3kYpg62y4dz9d1SZEowsIMiDYegjWjFGETCIwGJnCjVqaouyBN+0kdqbd4a+/DgOjH/RB6WTF7YOB5oPxziEKfBbRVGtt1vccS0O4gtmiun6KtdE73blV+E/mSmiebQv/u8f PublicKey\n"
  tags = {
     "entorno" = "terraform"
     "tipo"    = "publico"
     "test" : "test"
  }
}

output "ips_instancia_publica" {
  value = aws_instance.instancia_publica.public_ip
}
