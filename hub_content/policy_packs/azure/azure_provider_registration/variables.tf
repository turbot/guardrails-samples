variable "target_resource" {
  description = "Enter a target_resource to set the policies on a specific resource. This can be an AKA or resource id:"
  type        = string
}

variable "smart_folder_title" {
  description = "Folder to import the Azure Subscription:"
  type        = string
}

# Defaults to the Turbot Resource level using the AKA which identifies the Turbot level.
variable "folder_parent" {
  type    = string
  default = "tmod:@turbot/turbot#/"
}

# Enter the list of providers that you would like to "Skip", "Check: Not Registered", "Check: Registered", "Enforce: Not Registered" or "Enforce: Registered".
# Service names must match the "policy_map" below.
variable "provider_status" {
  description = "Choose the subset of providers that should be configured. Possible values for each service are: [\"Skip\", \"Check: Not Registered\", \"Check: Registered\", \"Enforce: Not Registered\", \"Enforce: Registered\"]"
  type        = map

  default = {
    ApiManagement       = "Skip"
    Compute             = "Skip"
    ContainerService    = "Skip"
    Databricks          = "Skip"
    DataFactory         = "Skip"
    DBforMySQL          = "Skip"
    DBforPostgreSQL     = "Skip"
    DocumentDB          = "Skip"
    DomainRegistration  = "Skip"
    Insights            = "Skip"
    KeyVault            = "Skip"
    Network             = "Skip"
    OperationalInsights = "Skip"
    RecoveryServices    = "Skip"
    Resources           = "Skip"
    Search              = "Skip"
    Security            = "Skip"
    Sql                 = "Skip"
    Storage             = "Skip"
    Web                 = "Skip"
  }
}

#This is a map of Turbot policy types to service names which should not be modified
variable "provider_registration_map" {
  description = "A map of all the registered policies currently exposed by Turbot"
  type        = map

  default = {
    ApiManagement       = "apiManagementRegistered"
    Compute             = "computeRegistered"
    ContainerService    = "containerServiceRegistered"
    Databricks          = "databricksRegistered"
    DataFactory         = "dataFactoryRegistered"
    DBforMySQL          = "dbforMySqlRegistered"
    DBforPostgreSQL     = "dbForPostgreSqlRegistered"
    DocumentDB          = "documentDbRegistered"
    DomainRegistration  = "domainRegistrationRegistered"
    Insights            = "insightsRegistered"
    KeyVault            = "keyVaultRegistered"
    Network             = "networkRegistered"
    OperationalInsights = "operationalInsightsRegistered"
    RecoveryServices    = "recoveryServicesRegistered"
    Resources           = "resourcesRegistered"
    Search              = "searchRegistered"
    Security            = "securityRegistered"
    Sql                 = "sqlRegistered"
    Storage             = "storageRegistered"
    Web                 = "webRegistered"
  }
}
