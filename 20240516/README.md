# Azure Cloud Shell

- https://learn.microsoft.com/en-us/azure/cloud-shell/overview
- https://learn.microsoft.com/en-us/training/modules/intro-to-azure-cloud-shell/
- https://learn.microsoft.com/en-us/cli/azure/reference-docs-index
- https://learn.microsoft.com/en-us/azure/cloud-shell/using-cloud-shell-editor

## az CLI

`az login --use-device-code`

`az ad signed-in-user show`

`az account list`

`az account set --subscription <subscription uuid>`

`az vm image list -f debian`

```sh
resourcegroup="<resource group uuid>"
location="westus3"
vmname="myVM"
username="azureuser"
az vm create --resource-group $resourcegroup --name $vmname --image Debian11 --public-ip-sku Standard --admin-username $username
```

`az vm show -d -g $resourcegroup -n $vmname --query publicIps`

## Terraform

Import an existing resource group, useful if you are using the Azure learn sandbox.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#import

`terraform import azurerm_resource_group.rg </subscriptions/<subscription uuid>/resourceGroups/<resource group uuid>`

Before running the above command you must have the resource group block definition in your tf file.

```
resource "azurerm_resource_group" "rg" {
  name     = "learn-c24e8603-7372-4b0b-8e13-8f28873078c6"
  location = "westus"
}
```

after the import you should run `terraform plan` and copy manually missed attributes to the resource group block until the plan operation show 0 differences!

Destroy the VM with `terraform destroy -target azurerm_linux_virtual_machine.example`

Format .tf files `terraform fmt .`
