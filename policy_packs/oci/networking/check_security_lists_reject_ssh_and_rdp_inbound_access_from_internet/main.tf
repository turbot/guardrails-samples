resource "turbot_policy_pack" "main" {
  title       = "Check If OCI Networking Security Lists Reject SSH and RDP Inbound Access From the Internet"
  description = "Reduce the risk of brute force and remote access attacks by alarming on security lists that allow SSH or RDP from the internet."
  akas        = ["oci_networking_check_security_lists_reject_ssh_and_rdp_inbound_access_from_internet"]
}
