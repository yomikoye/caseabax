# Define variables for region pairs
variable "env"{
    type = string
    description = "The deployment environment"
    default = "dev"
}

variable "regions" {
  type = map(string)
  description = "The name of the resource groups to create and location"
  default = {
    "us"     = "eastus2"
    "eu" = "westeurope"
    "asia" = "southeastasia"
  }
}

