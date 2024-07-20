resource "turbot_policy_pack" "main" {
  title       = "Enforce Install Packages On Instances Using SSM Package Installer"
  description = "Ensure that all package installations are managed and logged through AWS Systems Manager, enhancing security, compliance, and operational efficiency by providing centralized control and monitoring of software installations."
  akas        = ["aws_ssm_enforce_install_packages_on_instances_using_ssm_package_installer"]
}
