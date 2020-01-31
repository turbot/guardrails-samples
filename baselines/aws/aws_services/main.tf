resource "turbot_policy_setting" "aws_enable" {
  count       = length(var.service_status)
  resource    = var.target_resource
  type        = "tmod:@turbot/${element(keys(var.service_status), count.index)}#/policy/types/${lookup(var.policy_map, "${element(keys(var.service_status), count.index)}")}"
  value       = "${lookup(var.service_status, "${element(keys(var.service_status), count.index)}")}"
}