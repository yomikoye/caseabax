variable "env" {
  type = string
  description = "The name of the environment"
}

variable "db_name" {
  type = string
  description = "The name of the database"
}

variable "rg_name" {
  type = string
  description = "The name of the resource group to deploy the service to"
}


variable "location" {
  type = string
  description = "The Azure Region to deploy the service to"
  default = "westeurope"
}