resource "turbot_policy_setting" "aws_wellarchitected_rel01" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01
}
resource "turbot_policy_setting" "aws_wellarchitected_rel02" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel02"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel02
}
resource "turbot_policy_setting" "aws_wellarchitected_rel03" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel03"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel03
}
resource "turbot_policy_setting" "aws_wellarchitected_rel04" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel04"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel04
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06
}
resource "turbot_policy_setting" "aws_wellarchitected_rel07" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel07"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel07
}
resource "turbot_policy_setting" "aws_wellarchitected_rel08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel08"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel08
}
resource "turbot_policy_setting" "aws_wellarchitected_rel09" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel09"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel09
}
resource "turbot_policy_setting" "aws_wellarchitected_rel10" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel10"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel10
}
resource "turbot_policy_setting" "aws_wellarchitected_rel11" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel11"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel11
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12
}
resource "turbot_policy_setting" "aws_wellarchitected_rel13" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel13"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel13
}
resource "turbot_policy_setting" "aws_wellarchitected_rel01AwareFixedLimits" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01AwareFixedLimits"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01AwareFixedLimits
}
resource "turbot_policy_setting" "aws_wellarchitected_rel01AutomatedMonitorLimits" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01AutomatedMonitorLimits"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01AutomatedMonitorLimits
}
resource "turbot_policy_setting" "aws_wellarchitected_rel01MonitorManageLimits" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01MonitorManageLimits"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01MonitorManageLimits
}
resource "turbot_policy_setting" "aws_wellarchitected_rel01LimitsConsidered" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01LimitsConsidered"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01LimitsConsidered
}
resource "turbot_policy_setting" "aws_wellarchitected_rel01SuffBufferLimits" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01SuffBufferLimits"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01SuffBufferLimits
}
resource "turbot_policy_setting" "aws_wellarchitected_rel02NonOverlapIp" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel02NonOverlapIp"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel02NonOverlapIp
}
resource "turbot_policy_setting" "aws_wellarchitected_rel02IpSubnetAllocation" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel02IpSubnetAllocation"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel02IpSubnetAllocation
}
resource "turbot_policy_setting" "aws_wellarchitected_rel02HaConnPrivateNetworks" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel02HaConnPrivateNetworks"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel02HaConnPrivateNetworks
}
resource "turbot_policy_setting" "aws_wellarchitected_rel01AwareQuotasAndConstraints" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel01AwareQuotasAndConstraints"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel01AwareQuotasAndConstraints
}
resource "turbot_policy_setting" "aws_wellarchitected_rel03ApiContracts" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel03ApiContracts"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel03ApiContracts
}
resource "turbot_policy_setting" "aws_wellarchitected_rel02PreferHubAndSpoke" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel02PreferHubAndSpoke"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel02PreferHubAndSpoke
}
resource "turbot_policy_setting" "aws_wellarchitected_rel02HaConnUsers" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel02HaConnUsers"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel02HaConnUsers
}
resource "turbot_policy_setting" "aws_wellarchitected_rel04ConstantWork" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel04ConstantWork"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel04ConstantWork
}
resource "turbot_policy_setting" "aws_wellarchitected_rel03MonolithSoaMicroservice" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel03MonolithSoaMicroservice"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel03MonolithSoaMicroservice
}
resource "turbot_policy_setting" "aws_wellarchitected_rel03BusinessDomains" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel03BusinessDomains"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel03BusinessDomains
}
resource "turbot_policy_setting" "aws_wellarchitected_rel04Idempotent" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel04Idempotent"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel04Idempotent
}
resource "turbot_policy_setting" "aws_wellarchitected_rel04Identify" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel04Identify"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel04Identify
}
resource "turbot_policy_setting" "aws_wellarchitected_rel04LooselyCoupledSystem" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel04LooselyCoupledSystem"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel04LooselyCoupledSystem
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05FailFast" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05FailFast"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05FailFast
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05LimitRetries" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05LimitRetries"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05LimitRetries
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05ClientTimeouts" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05ClientTimeouts"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05ClientTimeouts
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05EmergencyLevers" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05EmergencyLevers"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05EmergencyLevers
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05ThrottleRequests" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05ThrottleRequests"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05ThrottleRequests
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05FailureStateless" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05FailureStateless"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05FailureStateless
}
resource "turbot_policy_setting" "aws_wellarchitected_rel05GracefulDegradation" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel05GracefulDegradation"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel05GracefulDegradation
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06AutomateResponseMonitor" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06AutomateResponseMonitor"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06AutomateResponseMonitor
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06EndToEnd" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06EndToEnd"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06EndToEnd
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06MonitorResources" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06MonitorResources"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06MonitorResources
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06NotificationAggregation" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06NotificationAggregation"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06NotificationAggregation
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06NotificationMonitor" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06NotificationMonitor"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06NotificationMonitor
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06ReviewMonitoring" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06ReviewMonitoring"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06ReviewMonitoring
}
resource "turbot_policy_setting" "aws_wellarchitected_rel06StorageAnalytics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel06StorageAnalytics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel06StorageAnalytics
}
resource "turbot_policy_setting" "aws_wellarchitected_rel07ProactiveAdaptAuto" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel07ProactiveAdaptAuto"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel07ProactiveAdaptAuto
}
resource "turbot_policy_setting" "aws_wellarchitected_rel07ReactiveAdaptAuto" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel07ReactiveAdaptAuto"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel07ReactiveAdaptAuto
}
resource "turbot_policy_setting" "aws_wellarchitected_rel07AutoscaleAdapt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel07AutoscaleAdapt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel07AutoscaleAdapt
}
resource "turbot_policy_setting" "aws_wellarchitected_rel07LoadTestedAdapt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel07LoadTestedAdapt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel07LoadTestedAdapt
}
resource "turbot_policy_setting" "aws_wellarchitected_rel08AutomatedChangemgmt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel08AutomatedChangemgmt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel08AutomatedChangemgmt
}
resource "turbot_policy_setting" "aws_wellarchitected_rel08FunctionalTesting" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel08FunctionalTesting"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel08FunctionalTesting
}
resource "turbot_policy_setting" "aws_wellarchitected_rel08ImmutableInfrastructure" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel08ImmutableInfrastructure"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel08ImmutableInfrastructure
}
resource "turbot_policy_setting" "aws_wellarchitected_rel08PlannedChangemgmt" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel08PlannedChangemgmt"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel08PlannedChangemgmt
}
resource "turbot_policy_setting" "aws_wellarchitected_rel08ResiliencyTesting" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel08ResiliencyTesting"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel08ResiliencyTesting
}
resource "turbot_policy_setting" "aws_wellarchitected_rel09AutomatedBackupsData" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel09AutomatedBackupsData"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel09AutomatedBackupsData
}
resource "turbot_policy_setting" "aws_wellarchitected_rel09PeriodicRecoveryTestingData" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel09PeriodicRecoveryTestingData"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel09PeriodicRecoveryTestingData
}
resource "turbot_policy_setting" "aws_wellarchitected_rel09SecuredBackupsData" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel09SecuredBackupsData"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel09SecuredBackupsData
}
resource "turbot_policy_setting" "aws_wellarchitected_rel09IdentifiedBackupsData" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel09IdentifiedBackupsData"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel09IdentifiedBackupsData
}
resource "turbot_policy_setting" "aws_wellarchitected_rel10UseBulkhead" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel10UseBulkhead"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel10UseBulkhead
}
resource "turbot_policy_setting" "aws_wellarchitected_rel10SingleAzSystem" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel10SingleAzSystem"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel10SingleAzSystem
}
resource "turbot_policy_setting" "aws_wellarchitected_rel11Failover2good" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel11Failover2good"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel11Failover2good
}
resource "turbot_policy_setting" "aws_wellarchitected_rel11AutoHealingSystem" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel11AutoHealingSystem"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel11AutoHealingSystem
}
resource "turbot_policy_setting" "aws_wellarchitected_rel11NotificationsSentSystem" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel11NotificationsSentSystem"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel11NotificationsSentSystem
}
resource "turbot_policy_setting" "aws_wellarchitected_rel11MonitoringHealth" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel11MonitoringHealth"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel11MonitoringHealth
}
resource "turbot_policy_setting" "aws_wellarchitected_rel10MultiazRegionSystem" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel10MultiazRegionSystem"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel10MultiazRegionSystem
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12RcaResiliency" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12RcaResiliency"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12RcaResiliency
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12FailureInjectionResiliency" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12FailureInjectionResiliency"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12FailureInjectionResiliency
}
resource "turbot_policy_setting" "aws_wellarchitected_rel11StaticStability" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel11StaticStability"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel11StaticStability
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12TestFunctional" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12TestFunctional"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12TestFunctional
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12GameDaysResiliency" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12GameDaysResiliency"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12GameDaysResiliency
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12PlaybookResiliency" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12PlaybookResiliency"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12PlaybookResiliency
}
resource "turbot_policy_setting" "aws_wellarchitected_rel13AutoRecovery" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel13AutoRecovery"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel13AutoRecovery
}
resource "turbot_policy_setting" "aws_wellarchitected_rel12TestNonFunctional" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel12TestNonFunctional"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel12TestNonFunctional
}
resource "turbot_policy_setting" "aws_wellarchitected_rel13ConfigDrift" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel13ConfigDrift"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel13ConfigDrift
}
resource "turbot_policy_setting" "aws_wellarchitected_rel13DisasterRecovery" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel13DisasterRecovery"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel13DisasterRecovery
}
resource "turbot_policy_setting" "aws_wellarchitected_rel13DrTested" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel13DrTested"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel13DrTested
}
resource "turbot_policy_setting" "aws_wellarchitected_rel13ObjectiveDefinedRecovery" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/rel13ObjectiveDefinedRecovery"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_rel13ObjectiveDefinedRecovery
}
