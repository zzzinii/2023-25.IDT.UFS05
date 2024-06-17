# App Service with Terraform

Following the official how to

https://learn.microsoft.com/en-us/azure/app-service/provision-resource-terraform


export TF_VAR_AZURE_RESOURCE_GROUP=learn-...

terraform init

terraform import azurerm_resource_group.rg '...'

az webapp log tail --name '...' --resource-group $TF_VAR_AZURE_RESOURCE_GROUP


node-red-dashboard