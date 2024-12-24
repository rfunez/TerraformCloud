variable "vpc_cidr" {
  type = string
}
variable "subnet_publica_cidr" {
  type = string
}
variable "subnet_privada_cidr" {
  type = string
}
variable "ip_publica_local" {
  type = string
}
variable "reglas_fw_publica" {
  type = list(object({
               protocolo = string,
               puerto = number}))
}
variable "tipo_instancia_publica" {
  type = string
}