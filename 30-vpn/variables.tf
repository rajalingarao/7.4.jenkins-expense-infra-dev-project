variable "common_tags" {
    type = map
    default = {
        Terraform   = "true"
        Environment = "Dev"
        Project     = "Expense"
    }
}
  variable "project_name" {
    type = string
    default = "Expense"
  }
  variable "environment" {
     default = "dev"    
  }

