provider "azurerm" {
    version = "2.5.0"
    features {}
}

terraform {
    backend "azurerm" {
        resource_group_name  = "bkmgmt"
        storage_account_name = "bkmgmttf"
        container_name       = "tfstatefiles" 
        key                  = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Eastus"
}

resource "azurerm_container_group" "tfcg_test" {
  name                      = "weatherapi"
  location                  = azurerm_resource_group.tf_test.location
  resource_group_name       = azurerm_resource_group.tf_test.name

  ip_address_type     = "public"
  dns_name_label      = "binarythistlewa"
  os_type             = "Linux"

  container {
      name            = "weatherapi"
      image           = "bk911/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port        = 80
            protocol    = "TCP"
        }
  }
}