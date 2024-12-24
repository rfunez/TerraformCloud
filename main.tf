resource "aws_vpc" "mi_vpc" {
  cidr_block = var.vpc_cidr
  provider = aws.espana
  tags = {
    Name = "VPC-Espana"
    entorno = "terraform"
  } 
}

resource "aws_subnet" "subnet_publica" {
    provider = aws.espana
    availability_zone = "eu-south-2a"
    map_public_ip_on_launch = true
    cidr_block = var.subnet_publica_cidr
    vpc_id = aws_vpc.mi_vpc.id
    tags = {
      Name = "SubnetPublica"
      tipo = "publica"
      entorno = "terraform"
    }
}

resource "aws_subnet" "subnet_privada" {
  provider = aws.espana
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
  provider = aws.espana
  vpc_id = aws_vpc.mi_vpc.id  
  tags = {
    Name = "IGEspana"
    entorno = "terraform"
  }
}

resource "aws_route_table" "rutas_subnet_pub" {
  provider = aws.espana
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
  provider = aws.espana  
  route_table_id = aws_route_table.rutas_subnet_pub.id
  subnet_id = aws_subnet.subnet_publica.id
}