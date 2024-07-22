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
  - |
    {
      item: bucket {
        Name
      }
      account {
        turbot {
          id
        }
      }
    }
  - |
    {
      resources(filter: "resourceId:{{ $.account.turbot.id }} resourceTypeId:'tmod:@turbot/aws-cloudfront#/resource/types/cloudFront' resourceTypeLevel:self $.DistributionConfig.Origins.Items.*.DomainName:'{{ $.item.Name }}.s3.amazonaws.com'")
      {
        items {
          ViewerProtocolPolicy: get(path:"DistributionConfig.DefaultCacheBehavior.ViewerProtocolPolicy")
          CacheBehaviorsItems: get(path:"DistributionConfig.CacheBehaviors.Items")
        }
      }
      item: bucket {
        Website: get(path:"Website")
      }
    }
  EOT
  template       = <<-EOT
    {%- if $.bucket.Website -%}

      {%- set policyValue = "Approved" -%}

      {%- if $.resources.items | length == 0 -%}

        {%- set policyValue = "Skip" -%}

      {%- else -%}

        {%- for item in $.resources.items -%}

          {%- if item.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}

            {%- set policyValue = "Not approved" -%}

          {%- else -%}

            {#- Check if the other cache behaviour is not secure, if not then `Not approved`-#}

            {%- for behaviorsItem in item.CacheBehaviorsItems -%}

              {%- if behaviorsItem.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}

                {%- set policyValue = "Not approved" -%}

              {%- endif -%}

            {%- endfor -%}

          {%- endif -%}

        {%- endfor -%}

        {%- if policyValue == "Approved" -%}

          {%- set data = {
              "title": "Secure CloudFront Distribution",
              "result": "Approved",
              "message": "CloudFront distribution is secured"
          } -%}

        {%- elif policyValue == "Not approved" -%}

          {%- set data = {
              "title": "Secure CloudFront Distribution",
              "result": "Not approved",
              "message": "CloudFront distribution is not secured"
          } -%}

        {%- else -%}

          {%- set data = {
              "title": "Secure CloudFront Distribution",
              "result": "Skip",
              "message": "No data for CloudFront distribution yet"
          } -%}

        {%- endif -%}

      {%- endif -%}

    {%- else -%}

      {%- set data = {
          "title": "Secure CloudFront Distribution",
          "result": "Skip",
          "message": "No data for website yet"
      } -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}
