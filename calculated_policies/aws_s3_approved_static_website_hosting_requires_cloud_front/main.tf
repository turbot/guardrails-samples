# Smart Folder Definition
resource "turbot_smart_folder" "s3_approved_usage_smart_folder" {
  title       = var.smart_folder_title
  description = var.smart_folder_description
  parent      = var.smart_folder_parent_resource
}

# AWS > Region > Bucket > Approved
resource "turbot_policy_setting" "s3_approved_policy_setting" {
  resource = turbot_smart_folder.s3_approved_usage_smart_folder.id
  type     = "tmod:@turbot/aws-s3#/policy/types/bucketApproved"
  value    = "Check: Approved"
}

# AWS > Region > Bucket > Approved > Usage
resource "turbot_policy_setting" "s3_approved_usage_policy_setting" {
  resource       = turbot_smart_folder.s3_approved_usage_smart_folder.id
  type           = "tmod:@turbot/aws-s3#/policy/types/bucketApprovedUsage"
  template_input = <<EOF
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
  EOF
  template       = <<EOF
  {#- Always approved if static website hosting is disabled -#}
  {%- set policyValue = "Approved" -%}

  {#- Is static website hosting is enabled -#}
  {%- if $.item.Website -%}

    {%- for item in $.resources.items -%}

      {#- Check if the the default cache behaviour is not secure, if not then `Not approved`-#}
      {%- if item.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}
        {#- Unapproved if an associated CloudFront distribution is set to http -#}
        {%- set policyValue = "Not approved" -%}
      {%- else -%}

        {#- Check if the the other cache behaviour is not secure, if not then `Not approved`-#}
        {%- for behaviorsItem in item.CacheBehaviorsItems -%}
          {%- if behaviorsItem.ViewerProtocolPolicy not in ["redirect-to-https", "https-only"] -%}
            {%- set policyValue = "Not approved" -%}
          {%- endif -%}
        {%- endfor -%}

      {%- endif -%}
    {%- else -%}
      {#- Unapproved if there is no associated CloudFront distribution -#}
      {%- set policyValue = "Not approved" -%}
    {%- endfor -%}

  {%- endif -%}

  {{ policyValue }}
  EOF
  precedence     = "REQUIRED"
}

# Attach Smart Folder
resource "turbot_smart_folder_attachment" "s3_approved_usage_smart_folder_attachment" {
  resource     = var.target_resource
  smart_folder = turbot_smart_folder.s3_approved_usage_smart_folder.id
}
