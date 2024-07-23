resource "turbot_policy_setting" "aws_wellarchitected_sec01" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03
}
resource "turbot_policy_setting" "aws_wellarchitected_sec04" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec04"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec04
}
resource "turbot_policy_setting" "aws_wellarchitected_sec05" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec05"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec05
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06
}
resource "turbot_policy_setting" "aws_wellarchitected_sec07" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec07"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec07
}
resource "turbot_policy_setting" "aws_wellarchitected_sec08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec08
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10
}
resource "turbot_policy_setting" "aws_wellarchitected_sec09" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec09"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec09
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01AwsAccount" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01AwsAccount"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01AwsAccount
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01ControlObjectives" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01ControlObjectives"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01ControlObjectives
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01ImplementServicesFeatures" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01ImplementServicesFeatures"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01ImplementServicesFeatures
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01MultiAccounts" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01MultiAccounts"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01MultiAccounts
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01TestValidatePipeline" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01TestValidatePipeline"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01TestValidatePipeline
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01ThreatModel" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01ThreatModel"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01ThreatModel
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01UpdatedRecommendations" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01UpdatedRecommendations"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01UpdatedRecommendations
}
resource "turbot_policy_setting" "aws_wellarchitected_sec01UpdatedThreats" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec01UpdatedThreats"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec01UpdatedThreats
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02Audit" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02Audit"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02Audit
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02EnforceMechanisms" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02EnforceMechanisms"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02EnforceMechanisms
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02GroupsAttributes" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02GroupsAttributes"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02GroupsAttributes
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02IdentityProvider" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02IdentityProvider"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02IdentityProvider
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02Secrets" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02Secrets"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02Secrets
}
resource "turbot_policy_setting" "aws_wellarchitected_sec02Unique" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec02Unique"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec02Unique
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03AnalyzeCrossAccount" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03AnalyzeCrossAccount"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03AnalyzeCrossAccount
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03ContinuousReduction" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03ContinuousReduction"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03ContinuousReduction
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03Define" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03Define"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03Define
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03DefineGuardrails" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03DefineGuardrails"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03DefineGuardrails
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03EmergencyProcess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03EmergencyProcess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03EmergencyProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03LeastPrivileges" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03LeastPrivileges"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03LeastPrivileges
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03Lifecycle" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03Lifecycle"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03Lifecycle
}
resource "turbot_policy_setting" "aws_wellarchitected_sec03ShareSecurely" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec03ShareSecurely"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec03ShareSecurely
}
resource "turbot_policy_setting" "aws_wellarchitected_sec04ActionableEvents" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec04ActionableEvents"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec04ActionableEvents
}
resource "turbot_policy_setting" "aws_wellarchitected_sec04AnalyzeAll" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec04AnalyzeAll"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec04AnalyzeAll
}
resource "turbot_policy_setting" "aws_wellarchitected_sec04AppServiceLogging" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec04AppServiceLogging"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec04AppServiceLogging
}
resource "turbot_policy_setting" "aws_wellarchitected_sec04AutoResponse" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec04AutoResponse"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec04AutoResponse
}
resource "turbot_policy_setting" "aws_wellarchitected_sec05AutoProtect" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec05AutoProtect"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec05AutoProtect
}
resource "turbot_policy_setting" "aws_wellarchitected_sec05CreateLayers" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec05CreateLayers"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec05CreateLayers
}
resource "turbot_policy_setting" "aws_wellarchitected_sec05Inspection" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec05Inspection"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec05Inspection
}
resource "turbot_policy_setting" "aws_wellarchitected_sec05Layered" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec05Layered"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec05Layered
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06ActionsDistance" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06ActionsDistance"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06ActionsDistance
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06AutoProtection" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06AutoProtection"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06AutoProtection
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06ImplementManagedServices" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06ImplementManagedServices"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06ImplementManagedServices
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06ReduceSurface" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06ReduceSurface"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06ReduceSurface
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06ValidateSoftwareIntegrity" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06ValidateSoftwareIntegrity"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06ValidateSoftwareIntegrity
}
resource "turbot_policy_setting" "aws_wellarchitected_sec06VulnerabilityManagement" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec06VulnerabilityManagement"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec06VulnerabilityManagement
}
resource "turbot_policy_setting" "aws_wellarchitected_sec07AutoClassification" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec07AutoClassification"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec07AutoClassification
}
resource "turbot_policy_setting" "aws_wellarchitected_sec07DefineProtection" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec07DefineProtection"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec07DefineProtection
}
resource "turbot_policy_setting" "aws_wellarchitected_sec07IdentifyData" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec07IdentifyData"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec07IdentifyData
}
resource "turbot_policy_setting" "aws_wellarchitected_sec07LifecycleManagement" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec07LifecycleManagement"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec07LifecycleManagement
}
resource "turbot_policy_setting" "aws_wellarchitected_sec08AccessControl" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08AccessControl"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec08AccessControl
}
resource "turbot_policy_setting" "aws_wellarchitected_sec08AutomateProtection" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08AutomateProtection"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec08AutomateProtection
}
resource "turbot_policy_setting" "aws_wellarchitected_sec08KeyMgmt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08KeyMgmt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec08KeyMgmt
}
resource "turbot_policy_setting" "aws_wellarchitected_sec08UsePeopleAway" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08UsePeopleAway"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec08UsePeopleAway
}
resource "turbot_policy_setting" "aws_wellarchitected_sec08Encrypt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec08Encrypt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec08Encrypt
}
resource "turbot_policy_setting" "aws_wellarchitected_sec09AutoUnintendedAccess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec09AutoUnintendedAccess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec09AutoUnintendedAccess
}
resource "turbot_policy_setting" "aws_wellarchitected_sec09Authentication" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec09Authentication"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec09Authentication
}
resource "turbot_policy_setting" "aws_wellarchitected_sec09Encrypt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec09Encrypt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec09Encrypt
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10AutoContain" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10AutoContain"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10AutoContain
}
resource "turbot_policy_setting" "aws_wellarchitected_sec09KeyCertMgmt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec09KeyCertMgmt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec09KeyCertMgmt
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10DevelopManagementPlans" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10DevelopManagementPlans"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10DevelopManagementPlans
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10IdentifyPersonnel" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10IdentifyPersonnel"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10IdentifyPersonnel
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10PreDeployTools" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10PreDeployTools"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10PreDeployTools
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10PreProvisionAccess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10PreProvisionAccess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10PreProvisionAccess
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10PrepareForensic" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10PrepareForensic"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_sec10PrepareForensic
}
resource "turbot_policy_setting" "aws_wellarchitected_sec10RunGameDays" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/sec10RunGameDays"
  resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_sec10RunGameDays
}
