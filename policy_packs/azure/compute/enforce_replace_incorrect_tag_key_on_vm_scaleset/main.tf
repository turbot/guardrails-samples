resource "turbot_policy_pack" "main" {
  title       = "Enforce Replace Incorrect Azure Tag Key on VM Scale Set"
  description = "This policy pack corrects inconsistent casing in Azure resource tag keys to ensure consistency."
  akas        = ["azure_compute_enforce_replace_incorrect_tag_key_on_vm_scaleset"]
}
