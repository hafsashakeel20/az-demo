resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location
  tags = {
    "Client" = var.client
    "ApplicationName" = var.appname
    "Owner" = var.owner
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = var.vnet_addr_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags = {
    "Client" = var.client
    "ApplicationName" = var.appname
    "Owner" = var.owner
  }
}

resource "azurerm_subnet" "internal" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.addr_prefixes
  
}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = var.ip_name
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = var.pvt_ip_alloc
  }
  tags = {
    "Client" = var.client
    "ApplicationName" = var.appname
    "Owner" = var.owner
  }
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = "${var.prefix}-vm"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.main.id]
  size               = var.vm_size
  admin_username = var.vm_username
  admin_password = var.vm_pwd
  disable_password_authentication = var.pwd_auth

  # Uncomment this line to delete the OS disk automatically when deleting the VM
#   delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
#   delete_data_disks_on_termination = true

  source_image_reference {
    publisher = var.img_publisher
    offer     = var.img_offer
    sku       = var.img_sku
    version   = var.img_version
  }
  os_disk {
    name              = var.disk_name
    caching           = var.disk_cache
    # create_option     = "FromImage"
    storage_account_type = var.disk_type
  }
#   os_profile {
#     computer_name  = "hostname"
#     admin_username = "testadmin"
#     admin_password = "Password1234!"
#   }
#   os_profile_linux_config {
#     disable_password_authentication = false
#   }
  tags = {
    "Client" = var.client
    "ApplicationName" = var.appname
    "Owner" = var.owner
    # environment = "staging"
  }
}