resource "azurerm_network_interface" "nic" {
  name                = "vm_nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "internal"
    subnet_id                     = "${var.subnet_id_test}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${var.public_ip_address_id}"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "myLinuxVM"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  size                  = "Standard_B1s"
  admin_username        = "${var.admin_username}"
  network_interface_ids = [azurerm_network_interface.nic.id]
  source_image_id       = "${var.packer_image}"
  disable_password_authentication = true
  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDK7C1tznwcN2AnNFUGTUUOlSJD3Q2DI+VKIitdEzKqmp/13rXDATgVOTvcX7rH+TM5ntGmTUpSXqJTxn+jDsKZ2xv+FNjyQUaWOZ+LmZb4vJQFilGziE8FDPNk3LSer7y2dzLeXkafkULRmPbWB8eAK2rMZKSiN8eMbFy2o0qADR4lziUBRNgoIT5iO6nwKSj+CBFY7mAsCQ1cdeytc4Qv9i2+/26s/cKopwUYmeMCEwFDZXWXvEacPYErFUIlTVwCk63jSVSrH4VA/0ruRZgUeh0kWayJyC7g+741Hjq9QWZLAOv0Q17/euADSWXE8OUNcyjj9ZRcmz76GAV92NKxFCyLZqZGkyxXPHiz+Xzj7XaDtbr5i69gBP1t6ylWtOA//zR06EZCOmD9CCJCuOORXTfWG0YeRGyezHeDfIiLeTOow2uqvB5h5h+znJR51dXegYhA5QVx0u0aXMxxFlZsb9IcFR7A8QNkLMVKKit2C4gpiYzen/dAhJssSpOiAnk= long@cc-2ede9415-bdd9d9c5b-mjq62"
  }
  os_disk {
    caching           = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  #source_image_reference {
  #  publisher = "Canonical"
  #  offer     = "UbuntuServer"
  #  sku       = "18.04-LTS"
  #  version   = "latest"
  #}
}
