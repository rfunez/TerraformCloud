vpc_cidr="172.22.20.0/26"

subnet_publica_cidr=[{cidr = "172.22.20.0/28",
                      zone = "eu-south-2a"},
                      {cidr = "172.22.20.32/28",
                       zone = "eu-south-2b"}]

subnet_privada_cidr=[{cidr = "172.22.20.16/28",
                      zone = "eu-south-2a"},
                     {cidr = "172.22.20.48/28",
                      zone = "eu-south-2b"}]

ip_publica_local = "0.0.0.0/0"

reglas_fw_publica = [{protocolo = "tcp",
                      puerto = 22},
                      {protocolo = "tcp",
                       puerto = 80}]

tipo_instancia_publica = "t3.micro"
