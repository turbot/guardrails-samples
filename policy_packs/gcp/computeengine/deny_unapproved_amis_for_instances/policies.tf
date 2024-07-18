# GCP > Compute Engine > Instance > Approved
resource "turbot_policy_setting" "gcp_computeengine_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Compute Engine > Instance > Approved > Custom
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedCustom"
  template_input = <<-EOT
    - |
      {
        resource {
          rootDiskName: get(path: "disks[0].source")
            # disks[].index: A zero-based index to this disk, where 0 is reserved for the boot disk.
            # If you have many disks attached to an instance, each disk would have a unique index number.
            # https://cloud.google.com/compute/docs/reference/rest/v1/instances
        }
      }
    - |
      {
        approvedGCPImages: constant(value: "['image1', 'image2']")
        disks: resources(filter: "resourceTypeId:'tmod:@turbot/gcp-computeengine#/resource/types/disk' $.name:{{ $.resource.rootDiskName.split('/').pop() }}"){
          items {
            sourceImage: get(path: "sourceImage")
            sourceImageId: get(path: "sourceImageId")
          }
        }
      }
    EOT
  template       = <<EOT
  {# For a new instance that is just created, there is a fraction of delay for the volume to be upserted and the CMDB run to complete. #}
  {# When the volumeCMDB is yet to finish but the instanceApproved is triggered, the second graphql query returns no results. #}
  {# Ofcourse, once the volumeCMDB runs successfully and discovers the attributes sourceImage and sourceImageId, the approved control is triggered again. #}
  {# Also, in extremely rare cases where the root disk is detached from the instance #}

  {% if $.disks.items | length == 0 %}

  - title: Image
    result: Skip
    message: Unable to find the source Image details or the root disk is detached from instance.

  {%- elif $.disks.items[0].sourceImageId in $.approvedGCPImages  %}

  - title: Image
    result: Approved
    message: Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is approved for usage.

  {% else %}

  - title: Image
    result: Not approved
    message: Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is not approved for usage.

  {%- endif -%}
EOT
}
