variable "common_tags" {
    type = map
    default = {
        Terraform   = "true"
        Environment = "Dev"
        Project     = "Expense"
        Component   = "backend"
    }
}
  variable "project_name" {
    type = string
    default = "Expense"
  }
  variable "environment" {
     default = "dev"    
  }
variable "zone_name" {
  default = "lithesh.shop"
}


