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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC5VpMEVQGLQ/YFvCcLj1BixKVfUM8UHUt3YbUCkQWSKN47PZUCS3tprr5TKh8bOhzyRZOwqtwyJvk4Abvh0t7l0eDKXuEzxGBkWH75RJPqdcEIGndZOn8TmUhb5pYoCTswHG1LRjqVjVGmhVJ2NRv8ofgViocl6Ln7vehuggt8HpN6LESYoB7sCfjc2zoY5ngFtQOKYj099GHYF96pXt43TNtiYaHJ6w82/tA0PyZAnEFBG8mYnarVQPVIE1mkJ7BooHtp8LQQwfuIfDtlv2iDyUIUiyILAZ7BKF1FB7NKoaxYYXoBerwDnO2x4hWPnZJKf+yizkd8PbsT2LCAKTfiyaWHHbsb6zJvP5LYxmsyLHcLZBke3yMsn0l8pNWctGrc+6Xv3S1nc/jKpXqtMWDm6JE/M0IhwnwCywtpXvGENn/ozSRMBiCHtpqUxjcG4IMeRuOkrXVRvQC5JUleEa64XlJRvtOvk3xkmopage1fiXFgOs7VSLe/wnNlEukdGn0= LongDV3@CVP00171973D"
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
