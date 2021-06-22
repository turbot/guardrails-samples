resource "turbot_policy_setting" "aws_wellarchitected_cost01" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03
}
resource "turbot_policy_setting" "aws_wellarchitected_cost04" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost04"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost04
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05
}
resource "turbot_policy_setting" "aws_wellarchitected_cost06" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost06"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost06
}
resource "turbot_policy_setting" "aws_wellarchitected_cost08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost08"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost08
}
resource "turbot_policy_setting" "aws_wellarchitected_cost07" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost07"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost07
}
resource "turbot_policy_setting" "aws_wellarchitected_cost09" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost09"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost09
}
resource "turbot_policy_setting" "aws_wellarchitected_cost10" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost10"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost10
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01BudgetForecast" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01BudgetForecast"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01BudgetForecast
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02Controls" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02Controls"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02Controls
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01Function" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01Function"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01Function
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01CostAwareness" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01CostAwareness"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01CostAwareness
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01Partnership" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01Partnership"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01Partnership
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01Scheduled" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01Scheduled"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01Scheduled
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01ProactiveProcess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01ProactiveProcess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01ProactiveProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_cost01UsageReport" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost01UsageReport"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost01UsageReport
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02GoalTarget" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02GoalTarget"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02GoalTarget
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02GroupsRoles" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02GroupsRoles"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02GroupsRoles
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02AccountStructure" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02AccountStructure"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02AccountStructure
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03AllocateOutcome" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03AllocateOutcome"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03AllocateOutcome
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02Policies" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02Policies"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02Policies
}
resource "turbot_policy_setting" "aws_wellarchitected_cost02TrackLifecycle" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost02TrackLifecycle"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost02TrackLifecycle
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03ConfigTools" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03ConfigTools"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03ConfigTools
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03OrgInformation" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03OrgInformation"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03OrgInformation
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03DefineAttribution" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03DefineAttribution"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03DefineAttribution
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03DetailedSource" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03DetailedSource"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03DetailedSource
}
resource "turbot_policy_setting" "aws_wellarchitected_cost03DefineKpi" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost03DefineKpi"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost03DefineKpi
}
resource "turbot_policy_setting" "aws_wellarchitected_cost04DecommAutomated" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost04DecommAutomated"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost04DecommAutomated
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05AnalyzeAll" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05AnalyzeAll"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05AnalyzeAll
}
resource "turbot_policy_setting" "aws_wellarchitected_cost04Track" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost04Track"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost04Track
}
resource "turbot_policy_setting" "aws_wellarchitected_cost04Decommission" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost04Decommission"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost04Decommission
}
resource "turbot_policy_setting" "aws_wellarchitected_cost04ImplementProcess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost04ImplementProcess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost04ImplementProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05AnalyzeOverTime" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05AnalyzeOverTime"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05AnalyzeOverTime
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05Licensing" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05Licensing"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05Licensing
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05Requirements" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05Requirements"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05Requirements
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05SelectForCost" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05SelectForCost"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05SelectForCost
}
resource "turbot_policy_setting" "aws_wellarchitected_cost05ThoroughAnalysis" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost05ThoroughAnalysis"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost05ThoroughAnalysis
}
resource "turbot_policy_setting" "aws_wellarchitected_cost06Metrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost06Metrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost06Metrics
}
resource "turbot_policy_setting" "aws_wellarchitected_cost07Analysis" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost07Analysis"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost07Analysis
}
resource "turbot_policy_setting" "aws_wellarchitected_cost06Data" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost06Data"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost06Data
}
resource "turbot_policy_setting" "aws_wellarchitected_cost06CostModeling" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost06CostModeling"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost08Modeling
}
resource "turbot_policy_setting" "aws_wellarchitected_cost07ImplementModels" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost07ImplementModels"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost07ImplementModels
}
resource "turbot_policy_setting" "aws_wellarchitected_cost07RegionCost" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost07RegionCost"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost07RegionCost
}
resource "turbot_policy_setting" "aws_wellarchitected_cost07ThirdParty" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost07ThirdParty"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost07ThirdParty
}
resource "turbot_policy_setting" "aws_wellarchitected_cost07MasterAnalysis" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost07MasterAnalysis"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost07MasterAnalysis
}
resource "turbot_policy_setting" "aws_wellarchitected_cost08Modeling" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost08Modeling"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost08Modeling
}
resource "turbot_policy_setting" "aws_wellarchitected_cost09BufferThrottle" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost09BufferThrottle"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost09BufferThrottle
}
resource "turbot_policy_setting" "aws_wellarchitected_cost08ImplementServices" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost08ImplementServices"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost08ImplementServices
}
resource "turbot_policy_setting" "aws_wellarchitected_cost10ReviewProcess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost10ReviewProcess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost10ReviewProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_cost09Dynamic" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost09Dynamic"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost09Dynamic
}
resource "turbot_policy_setting" "aws_wellarchitected_cost08OptimizedComponents" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost08OptimizedComponents"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost08OptimizedComponents
}
resource "turbot_policy_setting" "aws_wellarchitected_cost09CostAnalysis" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost09CostAnalysis"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost09CostAnalysis
}
resource "turbot_policy_setting" "aws_wellarchitected_cost10ReviewWorkload" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/cost10ReviewWorkload"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_cost10ReviewWorkload
}
