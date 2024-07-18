# AWS > S3 > Bucket > Approved
resource "turbot_policy_setting" "aws_s3_bucket_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new and empty"
}

# AWS > S3 > Bucket > Approved > Custom
resource "turbot_policy_setting" "aws_s3_bucket_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedCustom"
  template_input = <<-EOT
    {
      bucket: resource{
        replication: get(path:"Replication")
      }
      approvedReplicationAccountsList: constant(value: "['012345678901', '123456789012']")
    }
  EOT
  template       = <<-EOT
    {%- if $.bucket.replication and $.bucket.replication | length == 0 -%}

      {%- set data = {
          "title": "Replication",
          "result": "Approved",
          "message": "Bucket does not have replication enabled"
      } -%}

    {%- elif $.bucket.replication -%}

      {%- set replicationApproved = true -%}

      {%- for rule in $.bucket.replication.Rules -%}

        {%- if rule.Destination.Account not in $.approvedReplicationAccountsList -%}

        {%- set replicationApproved = false -%}

        {%- endif -%}

      {%- endfor -%}

      {%- if replicationApproved -%}

        {%- set data = {
            "title": "Replication",
            "result": "Approved",
            "message": "Replication destination account(s) approved"
        } -%}
      {%- else -%}

        {%- set data = {
            "title": "Replication",
            "result": "Not approved",
            "message": "Replication destination account(s) not approved"
        } -%}

      {%- endif %}

    {%- else -%}

      {%- set data = {
          "title": "Replication",
          "result": "Skip",
          "message": "No data for replication yet"
      } -%}

    {% endif %}

    {{ data | json }}
  EOT
}
