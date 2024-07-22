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
    }
  - |
    {
      resources(filter: "$.DistributionConfig.Origins.Items.*.DomainName:'{{ $.item.Name }}.s3.amazonaws.com' resourceTypeId:tmod:@turbot/aws-cloudfront#/resource/types/cloudFront")
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
    {#- Always approved if static website hosting is disabled -#}

    {%- set data = {
        "title": "Static Website Hosting",
        "result": "Approved",
        "message": "Static website hosting is disabled"
    } -%}

    {#- Is static website hosting enabled -#}

    {%- if $.bucket.Website -%}

      {%- set policyValue = "Approved" -%}

      {%- for item in $.resources.items -%}

        {#- Check if the default cache behaviour is not secure, if not then `Not approved`-#}

        {%- if item.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}

          {#- Unapproved if an associated CloudFront distribution is set to http -#}

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

      {%- if $.resources.items | length == 0 -%}

        {#- Skip if there is no associated CloudFront distribution data available yet -#}
        {%- set policyValue = "Skip" -%}

      {%- endif -%}

      {%- if policyValue == "Approved" -%}

        {%- set data = {
            "title": "Static Website Hosting",
            "result": "Approved",
            "message": "Static website hosting is enabled and all associated CloudFront distributions are secure"
        } -%}

      {%- elif policyValue == "Skip" -%}

        {%- set data = {
            "title": "Static Website Hosting",
            "result": "Skip",
            "message": "No associated CloudFront distribution data available yet"
        } -%}

      {%- else -%}

        {%- set data = {
            "title": "Static Website Hosting",
            "result": "Not approved",
            "message": "Static website hosting is enabled but not all associated CloudFront distributions are secure"
        } -%}

      {%- endif -%}

    {%- endif -%}

    {{ data | json }}
  EOT
}


