variable "top_folder" {
    description     = "Parent resource for the top level folder, ACME"
    type            = string
    default         = "tmod:@turbot/turbot#/"
}

variable "top_folder_title" {
    description     = "Title of top level folder."
    type            = string
    default         = "ACME"
}

variable "top_folder_description" {
    description     = "Description of the top level folder"
    type            = string
    default         = "Top level folder for ACME"
}

variable "top_dev_title" {
    description     = "Title for top level Dev folder"
    type            = string
    default         = "Dev"
}

variable "top_dev_folder_description" {
    description     = "Description for top level Dev folder"
    type            = string
    default         = "Top level folder for Dev environment"
}

variable "top_prod_title" {
    description     = "Title for the top level Prod folder"
    type            = string
    default         = "Prod"
}

variable "top_prod_folder_description" {
    description     = "Description for the top level Prod folder"
    type            = string
    default         = "Top level folder for Prod environment"
}

variable "dev_it_title" {
    description     = "Title for Dev IT folder"
    type            = string   
    default         = "Dev IT"
}

variable "dev_it_description" {
    description     = "Description for Dev IT folder"
    type            = string
    default         = "Dev IT folder"
}

variable "dev_apps_title" {
    description     = "Description for Dev Apps folder"
    type            = string
    default         = "Dev Apps"
}

variable "dev_apps_description" {
    description     = "Description for Dev Apps folder"
    type            = string
    default         = "Dev Apps folder"
}

variable "prod_it_title" {
    description     = "Title for Prod IT folder"
    type            = string   
    default         = "Prod IT"
}

variable "prod_it_description" {
    description     = "Description for Prod IT folder"
    type            = string
    default         = "Prod IT folder"
}

variable "prod_apps_title" {
    description     = "Description for Prod Apps folder"
    type            = string
    default         = "Prod Apps"
}

variable "prod_apps_description" {
    description     = "Description for Prod Apps folder"
    type            = string
    default         = "Prod Apps folder"
}