variable "location" {
  type = string
  description = "The Azure Region to deploy the service to"
  default = "westeurope"
}

variable "rg_name" {
  type = string
  description = "The name of the resource group to deploy the service to"
}

variable "env" {
  type = string
  description = "The name of the environment"
}

variable "region_name" {
  type = string
  description = "The name of the storage account"
}

variable "primary_sql_connection_string" {
  type = string
  description = "Primary SQL connection string for the CosmosDB Account."
}

variable "endpoint" {
  type = string
  description = "The endpoint used to connect to the CosmosDB account."
}

variable "services" {
  type = map(object({
    name  = string
  }))
  default = {
    upload = {
      name  = "upload"
    }
    download = {
      name  = "download"
    }
    search = {
      name  = "search"
    }
    metadata = {
      name  = "metadata"
    }
  }
}
