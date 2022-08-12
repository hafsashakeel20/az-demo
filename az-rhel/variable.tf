variable "prefix" {
  default = "hafsa-rhel"
}
variable "location" {
    type = string  
}
variable "client" {
    type = string
}
variable "appname" {
    type = string  
}
variable "owner" {
    type = string  
}
variable "vnet_addr_space" {
    type = list  
}
variable "subnet_name" {
    type = string  
}
variable "addr_prefixes" {
    type = list  
}
variable "ip_name" {
    type = string
}
variable "pvt_ip_alloc" {
    type = string  
}
variable "vm_size" {
    type = string  
}
variable "vm_username" {
    type = string  
}
variable "vm_pwd" {
    type = string  
}
variable "pwd_auth" {
    type = bool  
}
variable "img_publisher" {
    type = string  
}
variable "img_offer" {
    type = string  
}
variable "img_sku" {
    type = string  
}
variable "img_version" {
    type = string  
}
variable "disk_name" {
    type = string  
}
variable "disk_cache" {
    type = string  
}
variable "disk_type" {
    type = string  
}