resource "aws_vpc" "mi_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "VPC-Espana"
    entorno = "terraform"
  } 
}

resource "aws_subnet" "subnet_publica" {
    count = 2
    availability_zone = var.subnet_publica_cidr[count.index].zone
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.mi_vpc.id
    cidr_block = var.subnet_publica_cidr[count.index].cidr
    tags = {
      Name = "SubnetPublica-${count.index}"
      tipo = "publica"
      entorno = "terraform"
    }
}

resource "aws_subnet" "subnet_privada" {
  availability_zone = "eu-south-2b"
  vpc_id = aws_vpc.mi_vpc.id
  cidr_block = var.subnet_privada_cidr
  tags = {
    Name = "SubnetPrivada"
    tipo= "privada"
    entorno = "terraform"
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.mi_vpc.id  
  tags = {
    Name = "IGEspana"
    entorno = "terraform"
  }
}

resource "aws_route_table" "rutas_subnet_pub" {
  vpc_id = aws_vpc.mi_vpc.id
  depends_on = [ aws_subnet.subnet_publica ]
  route {
    cidr_block = var.ip_publica_local
    gateway_id = aws_internet_gateway.internet-gw.id
  }
  tags = {
    Name = "Publica"
    entorno = "terraform"
  }
}

resource "aws_route_table_association" "asociacion_subnet" {
  depends_on = [ aws_route_table.rutas_subnet_pub ]
  count = length(var.subnet_publica_cidr)
  route_table_id = aws_route_table.rutas_subnet_pub.id
  subnet_id = aws_subnet.subnet_publica[count.index].id
}