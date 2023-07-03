provider "azurerm" {
  skip_provider_registration = "true"
  tenant_id       = "${var.tenant_id}"
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  features {}
}
terraform {
  backend "azurerm" {
    storage_account_name = "tfstate2583313850"
    container_name       = "tfstate"
    key                  = "test.terraform.tfstate"
    access_key           = "EjHYePeVlR8xZIgEzSY7tfeRbb0JNl9jJFUd4huUHbnsPPZIg5bMTI/alq8kgg3ZWTM80Q7SfMbN+AStkKP0wg=="
  }
}
module "resource_group" {
  source               = "../../modules/resource_group"
  resource_group_name       = "${var.resource_group_name}"
  location             = "${var.location}"
}
module "network" {
  source               = "../../modules/network"
  address_space        = "${var.address_space}"
  location             = "${var.location}"
  virtual_network_name = "${var.virtual_network_name}"
  application_type     = "${var.application_type}"
  resource_type        = "NET"
  resource_group_name  = "${module.resource_group.resource_group_name}"
  address_prefix_test  = "${var.address_prefix_test}"
}

module "nsg-test" {
  source           = "../../modules/networksecuritygroup"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "NSG"
  resource_group_name   = "${module.resource_group.resource_group_name}"
  subnet_id        = "${module.network.subnet_id_test}"
  address_prefix_test = "${var.address_prefix_test}"
  source_address_prefix_test = "${var.source_address_prefix_test}"
}
module "appservice" {
  source           = "../../modules/appservice"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "AppService"
  resource_group_name   = "${module.resource_group.resource_group_name}"
}
module "publicip" {
  source           = "../../modules/publicip"
  location         = "${var.location}"
  application_type = "${var.application_type}"
  resource_type    = "publicip"
  resource_group_name   = "${module.resource_group.resource_group_name}"
}
#module "vm" {
#  source               = "../../modules/vm"
#  location             = "${var.location}"
#  resource_group_name  = "${module.resource_group.resource_group_name}"
#
#  admin_username       = "${var.admin_username}"
#  subnet_id_test       = "${module.network.subnet_id_test}"
#  public_ip_address_id = "${module.publicip.public_ip_address_id}"
#}
