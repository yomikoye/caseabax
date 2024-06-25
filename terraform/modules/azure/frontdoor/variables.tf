variable "env" {
  type = string
  description = "The name of the environment"
}

variable "rg_name" {
  type = string
  description = "The name of the resource group to deploy the service to"
}

variable "webapps" {
  description = "The webapps to add to frontdoor"
}