# Initalize the Turbot provider
provider turbot {}

# Top level folder
resource "turbot_folder" "acme" {
    parent          = "tmod:@turbot/turbot#"
    title           = var.top_folder_title
    description     = var.top_folder_description
}

# Top level Dev folder, acme folder is parent
resource "turbot_folder" "top_dev" {
    parent          = turbot_folder.acme.id
    title           = var.top_dev_title
    description     = var.top_dev_folder_description
}

# Top level Prod folder, acme folder is parent
resource "turbot_folder" "top_prod" {
    parent          = turbot_folder.acme.id
    title           = var.top_prod_title
    description     = var.top_prod_folder_description
}

# Example business units within Dev. Each business unit gets it's own folder.
resource "turbot_folder" "dev_it" {
    parent          = turbot_folder.top_dev.id
    title           = var.dev_it_title
    description     = var.dev_it_description
}

resource "turbot_folder" "dev_apps" {
    parent          = turbot_folder.top_dev.id
    title           = var.dev_apps_title
    description     = var.dev_apps_description
}

# Example business units within Prod. Each business unit gets it's own folder.
resource "turbot_folder" "prod_it" {
    parent          = turbot_folder.top_prod.id
    title           = var.prod_it_title
    description     = var.prod_it_description
}

resource "turbot_folder" "prod_apps" {
    parent          = turbot_folder.top_prod.id
    title           = var.prod_apps_title
    description     = var.prod_apps_description
}