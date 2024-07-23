
resource "turbot_policy_setting" "aws_wellarchitected_ops01" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03
}
resource "turbot_policy_setting" "aws_wellarchitected_ops04" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops04"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops04
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06
}
resource "turbot_policy_setting" "aws_wellarchitected_ops07" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops07"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops07
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01ComplianceReqs" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01ComplianceReqs"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01ComplianceReqs
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01ExtCustNeeds" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01ExtCustNeeds"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01ExtCustNeeds
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01EvalThreatLandscape" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01EvalThreatLandscape"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01EvalThreatLandscape
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01ManageRiskBenefit" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01ManageRiskBenefit"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01ManageRiskBenefit
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02DefActivityOwners" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02DefActivityOwners"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02DefActivityOwners
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01IntCustNeeds" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01IntCustNeeds"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01ExtCustNeeds
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01EvalTradeoffs" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01EvalTradeoffs"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01EvalTradeoffs
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02FindOwner" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02FindOwner"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02FindOwner
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02DefResourceOwners" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02DefResourceOwners"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02DefResourceOwners
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02DefNegTeamAgreements" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02DefNegTeamAgreements"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02DefNegTeamAgreements
}
resource "turbot_policy_setting" "aws_wellarchitected_ops01GovernanceReqs" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops01GovernanceReqs"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops01GovernanceReqs
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03EffectiveComms" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03EffectiveComms"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03EffectiveComms
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02ReqAddChgException" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02ReqAddChgException"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02ReqAddChgException
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02DefProcOwners" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02DefProcOwners"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02DefProcOwners
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03ExecutiveSponsor" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03ExecutiveSponsor"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03ExecutiveSponsor
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03DiverseIncAccess" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03DiverseIncAccess"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03DiverseIncAccess
}
resource "turbot_policy_setting" "aws_wellarchitected_ops02KnowMyJob" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops02KnowMyJob"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops02KnowMyJob
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03TeamResAppro" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03TeamResAppro"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03TeamResAppro
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03TeamEncExperiment" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03TeamEncExperiment"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03TeamEncExperiment
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03TeamEmpTakeAction" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03TeamEmpTakeAction"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03TeamEmpTakeAction
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03TeamEncEscalation" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03TeamEncEscalation"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03TeamEncEscalation
}
resource "turbot_policy_setting" "aws_wellarchitected_ops04ApplicationTelemetry" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops04ApplicationTelemetry"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops04ApplicationTelemetry
}
resource "turbot_policy_setting" "aws_wellarchitected_ops03TeamEncLearn" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops03TeamEncLearn"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops03TeamEncLearn
}
resource "turbot_policy_setting" "aws_wellarchitected_ops04CustomerTelemetry" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops04CustomerTelemetry"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops04CustomerTelemetry
}
resource "turbot_policy_setting" "aws_wellarchitected_ops04DependencyTelemetry" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops04DependencyTelemetry"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops04DependencyTelemetry
}
resource "turbot_policy_setting" "aws_wellarchitected_ops04DistTrace" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops04DistTrace"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops04DistTrace
}
resource "turbot_policy_setting" "aws_wellarchitected_ops04WorkloadTelemetry" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops04WorkloadTelemetry"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops04WorkloadTelemetry
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05AutoIntegDeploy" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05AutoIntegDeploy"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05AutoIntegDeploy
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05ConfMgmtSys" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05ConfMgmtSys"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05ConfMgmtSys
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05BuildMgmtSys" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05BuildMgmtSys"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05BuildMgmtSys
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05ShareDesignStds" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05ShareDesignStds"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05ShareDesignStds
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05PatchMgmt" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05PatchMgmt"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05PatchMgmt
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06AutoTestingAndRollback" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06AutoTestingAndRollback"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06AutoTestingAndRollback
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05CodeQuality" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05CodeQuality"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05CodeQuality
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05FreqSmRevChg" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05FreqSmRevChg"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05FreqSmRevChg
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05TestValChg" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05TestValChg"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05TestValChg
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05MultiEnv" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05MultiEnv"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05MultiEnv
}
resource "turbot_policy_setting" "aws_wellarchitected_ops05VersionControl" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops05VersionControl"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops05VersionControl
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06DeployToParallelEnv" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06DeployToParallelEnv"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06DeployToParallelEnv
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06FreqSmRevChg" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06FreqSmRevChg"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06FreqSmRevChg
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06AutoIntegDeploy" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06AutoIntegDeploy"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06AutoIntegDeploy
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06TestLimitedDeploy" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06TestLimitedDeploy"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06TestLimitedDeploy
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06TestValChg" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06TestValChg"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06TestValChg
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06DeployMgmtSys" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06DeployMgmtSys"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06DeployMgmtSys
}
resource "turbot_policy_setting" "aws_wellarchitected_ops07UsePlaybooks" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops07UsePlaybooks"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops07UsePlaybooks
}
resource "turbot_policy_setting" "aws_wellarchitected_ops07ConstOrr" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops07ConstOrr"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops07ConstOrr
}
resource "turbot_policy_setting" "aws_wellarchitected_ops06PlanForUnsucessfulChanges" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops06PlanForUnsucessfulChanges"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops06PlanForUnsucessfulChanges
}
resource "turbot_policy_setting" "aws_wellarchitected_ops07UseRunbooks" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops07UseRunbooks"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops07UseRunbooks
}
resource "turbot_policy_setting" "aws_wellarchitected_ops07InformedDeployDecisions" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops07InformedDeployDecisions"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops07InformedDeployDecisions
}
resource "turbot_policy_setting" "aws_wellarchitected_ops07PersonnelCapability" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops07PersonnelCapability"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops07PersonnelCapability
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08BizLevelViewWorkload" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08BizLevelViewWorkload"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08BizLevelViewWorkload
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08CollectAnalyzeWorkloadMetrics" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08CollectAnalyzeWorkloadMetrics"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08CollectAnalyzeWorkloadMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08DefineWorkloadKpis" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08DefineWorkloadKpis"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08DefineWorkloadKpis
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08DesignWorkloadMetrics" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08DesignWorkloadMetrics"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08DesignWorkloadMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08LearnWorkloadUsagePatterns" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08LearnWorkloadUsagePatterns"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08LearnWorkloadUsagePatterns
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08WorkloadAnomalyAlerts" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08WorkloadAnomalyAlerts"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08WorkloadAnomalyAlerts
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08WorkloadMetricBaselines" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08WorkloadMetricBaselines"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08WorkloadMetricBaselines
}
resource "turbot_policy_setting" "aws_wellarchitected_ops08WorkloadOutcomeAlerts" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops08WorkloadOutcomeAlerts"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops08WorkloadOutcomeAlerts
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09DefineOpsKpis" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09DefineOpsKpis"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09DefineOpsKpis
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09BizLevelViewOps" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09BizLevelViewOps"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09BizLevelViewOps
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09DesignOpsMetrics" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09DesignOpsMetrics"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09DesignOpsMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09OpsAnomalyAlerts" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09OpsAnomalyAlerts"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09OpsAnomalyAlerts
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09OpsMetricBaselines" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09OpsMetricBaselines"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09OpsMetricBaselines
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09CollectAnalyzeOpsMetrics" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09CollectAnalyzeOpsMetrics"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09CollectAnalyzeOpsMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10AutoEventResponse" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10AutoEventResponse"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10AutoEventResponse
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09OpsOutcomeAlerts" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09OpsOutcomeAlerts"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09OpsOutcomeAlerts
}
resource "turbot_policy_setting" "aws_wellarchitected_ops09LearnOpsUsagePatterns" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops09LearnOpsUsagePatterns"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops09LearnOpsUsagePatterns
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10PushNotify" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10PushNotify"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10PushNotify
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10EventIncidentProblemProcess" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10EventIncidentProblemProcess"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10EventIncidentProblemProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10Dashboards" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10Dashboards"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10Dashboards
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10DefineEscalationPaths" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10DefineEscalationPaths"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10DefineEscalationPaths
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11AllocateTimeForImp" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11AllocateTimeForImp"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11AllocateTimeForImp
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10PrioritizeEvents" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10PrioritizeEvents"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10PrioritizeEvents
}
resource "turbot_policy_setting" "aws_wellarchitected_ops10ProcessPerAlert" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops10ProcessPerAlert"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops10ProcessPerAlert
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11DriversForImp" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11DriversForImp"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11DriversForImp
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11FeedbackLoops" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11FeedbackLoops"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11FeedbackLoops
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11KnowledgeManagement" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11KnowledgeManagement"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11KnowledgeManagement
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11MetricsReview" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11MetricsReview"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11MetricsReview
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11PerformRcaProcess" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11PerformRcaProcess"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11PerformRcaProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11ProcessContImp" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11ProcessContImp"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11ProcessContImp
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11ShareLessonsLearned" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11ShareLessonsLearned"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11ShareLessonsLearned
}
resource "turbot_policy_setting" "aws_wellarchitected_ops11ValidateInsights" {
 type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/ops11ValidateInsights"
resource = turbot_smart_folder.well_architected_pillars.id
value = var.aws_waf_ops11ValidateInsights
}
