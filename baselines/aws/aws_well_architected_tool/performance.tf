resource "turbot_policy_setting" "aws_wellarchitected_perf01" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02
}
resource "turbot_policy_setting" "aws_wellarchitected_perf03" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf03"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf03
}
resource "turbot_policy_setting" "aws_wellarchitected_perf04" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf04"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf04
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05
}
resource "turbot_policy_setting" "aws_wellarchitected_perf06" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf06"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf06
}
resource "turbot_policy_setting" "aws_wellarchitected_perf08" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf08"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf08
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01Benchmark" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01Benchmark"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01Benchmark
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01Cost" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01Cost"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01Cost
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01EvaluateResources" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01EvaluateResources"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01EvaluateResources
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01ExternalGuidance" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01ExternalGuidance"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01ExternalGuidance
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01LoadTest" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01LoadTest"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01LoadTest
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01Process" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01Process"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01Process
}
resource "turbot_policy_setting" "aws_wellarchitected_perf01UsePolicies" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf01UsePolicies"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf01UsePolicies
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02CollectMetrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02CollectMetrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02CollectMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02ConfigOptions" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02ConfigOptions"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02ConfigOptions
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02Elasticity" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02Elasticity"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02Elasticity
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02EvaluateOptions" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02EvaluateOptions"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02EvaluateOptions
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02RightSizing" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02RightSizing"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02RightSizing
}
resource "turbot_policy_setting" "aws_wellarchitected_perf02UseMetrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf02UseMetrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf02UseMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_perf03EvaluatedOptions" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf03EvaluatedOptions"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf03EvaluatedOptions
}
resource "turbot_policy_setting" "aws_wellarchitected_perf03OptimizePatterns" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf03OptimizePatterns"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf03OptimizePatterns
}
resource "turbot_policy_setting" "aws_wellarchitected_perf03UnderstandChar" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf03UnderstandChar"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf03UnderstandChar
}
resource "turbot_policy_setting" "aws_wellarchitected_perf04AccessPatterns" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf04AccessPatterns"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf04AccessPatterns
}
resource "turbot_policy_setting" "aws_wellarchitected_perf04CollectMetrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf04CollectMetrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf04CollectMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_perf04EvaluateOptions" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf04EvaluateOptions"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf04EvaluateOptions
}
resource "turbot_policy_setting" "aws_wellarchitected_perf04OptimizeMetrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf04OptimizeMetrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf04OptimizeMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_perf04UnderstandChar" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf04UnderstandChar"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf04UnderstandChar
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05EncryptionOffload" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05EncryptionOffload"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05EncryptionOffload
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05EvaluateFeatures" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05EvaluateFeatures"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05EvaluateFeatures
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05Hybrid" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05Hybrid"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05Hybrid
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05Location" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05Location"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05Location
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05Optimize" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05Optimize"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05Optimize
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05Protocols" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05Protocols"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05Protocols
}
resource "turbot_policy_setting" "aws_wellarchitected_perf05UnderstandImpact" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf05UnderstandImpact"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf05UnderstandImpact
}
resource "turbot_policy_setting" "aws_wellarchitected_perf06DefineProcess" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf06DefineProcess"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf06DefineProcess
}
resource "turbot_policy_setting" "aws_wellarchitected_perf06Evolve" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf06Evolve"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf06Evolve
}
resource "turbot_policy_setting" "aws_wellarchitected_perf06KeepUpToDate" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf06KeepUpToDate"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf06KeepUpToDate
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07EstablishKpi" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07EstablishKpi"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07EstablishKpi
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07GenerateAlarms" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07GenerateAlarms"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07GenerateAlarms
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07Proactive" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07Proactive"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07Proactive
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07RecordMetrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07RecordMetrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07RecordMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07ReviewMetrics" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07ReviewMetrics"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07ReviewMetrics
}
resource "turbot_policy_setting" "aws_wellarchitected_perf07ReviewMetricsCollected" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf07ReviewMetricsCollected"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf07ReviewMetricsCollected
}
resource "turbot_policy_setting" "aws_wellarchitected_perf08CriticalAreas" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf08CriticalAreas"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf08CriticalAreas
}
resource "turbot_policy_setting" "aws_wellarchitected_perf08DesignPatterns" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf08DesignPatterns"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf08DesignPatterns
}
resource "turbot_policy_setting" "aws_wellarchitected_perf08ImplementStrategy" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf08ImplementStrategy"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf08ImplementStrategy
}
resource "turbot_policy_setting" "aws_wellarchitected_perf08Measure" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf08Measure"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf08Measure
}
resource "turbot_policy_setting" "aws_wellarchitected_perf08UnderstandImpact" {
  type = "tmod:@turbot/aws-wellarchitected-framework#/policy/types/perf08UnderstandImpact"
  resource = turbot_smart_folder.well_architected_pillars.id
  value = var.aws_waf_perf08UnderstandImpact
}
