# This file contains policies which are not decided to enable part of initial baseline policies. 
# If you want to enable them, change the vale to true and execute terraform apply by passing the demo.tfvar file. 
# See README for more details.

# See file service_account_key_policies.tf
service_account_key_approved_policies = false
service_account_key_approved_usage_policies = false

# See file service_account_policy_trust_policies.tf
enable_service_account_policy_trusted_domains_policies = false
