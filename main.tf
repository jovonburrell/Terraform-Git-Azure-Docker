provider "azurerm" {
features {}  
}

terraform {
  backend "azurerm"{
    resource_group_name = "Tfstate_rg"
    storage_account_name = "tfstorageredstripe555"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}

variable "imagebuild"{
  type = string
  description = "Latest image build"
} 
resource "azurerm_resource_group" "ft_lab" {
name = "weather-rg"
location = "southcentralus" 
}

resource "azurerm_container_group" "tfcg_test" {
name = "weatherapi"
location = azurerm_resource_group.ft_lab.location
resource_group_name = azurerm_resource_group.ft_lab.name

ip_address_type = "public"
dns_name_label = "redstripe555wa"
os_type = "Linux"

container {
  name = "weatherapi"
  image = "redstripe555/weatherapi:${var.imagebuild}"
  cpu = "1"
  memory = "1"

  ports {
    port = 80
    protocol = "TCP"
  }
}

}