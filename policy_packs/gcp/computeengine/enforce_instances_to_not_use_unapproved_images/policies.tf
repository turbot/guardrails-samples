# GCP > Compute Engine > Instance > Approved
resource "turbot_policy_setting" "gcp_computeengine_instance_approved" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  value    = "Check: Approved"
  # value    = "Enforce: Stop unapproved"
  # value    = "Enforce: Delete unapproved if new"
}

# GCP > Compute Engine > Instance > Approved > Custom
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_custom" {
  resource       = turbot_policy_pack.main.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedCustom"
  template_input = <<-EOT
  - |
    {
      project {
        turbot {
          id
        }
      }
      resource {
        rootDiskName: get(path: "disks[0].deviceName")
      }
    }
  - |
    {
      disks: resources(filter: "resourceTypeId:'tmod:@turbot/gcp-computeengine#/resource/types/disk' $.name:{{ $.resource.rootDiskName }} resourceId:{{ $.project.turbot.id }} resourceTypeLevel:self") {
        items {
          sourceImage: get(path: "sourceImage")
          sourceImageId: get(path: "sourceImageId")
        }
      }
      # Your list of approved image IDs
      approvedImageIds: constant(value: "['4644004327634874935', '4801817364715522935']")
    }
  EOT
  template       = <<-EOT
  {%- if $.disks.items | length > 0 and $.disks.items[0].sourceImageId in $.approvedImageIds -%}

    {%- set data = {
        "title": "Image"
        "result": "Approved"
        "message": Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is approved for usage
    } -%}

  {%- elif $.disks.items | length > 0 and $.disks.items[0].sourceImageId not in $.approvedImageIds -%}

    {%- set data = {
        "title": "Image"
        "result": "Not approved"
        "message": Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is not approved for usage
    } -%}
  
  {%- else -%}

    {%- set data = {
        "title": "Image",
        "result": "Skip",
        "message": "No data for image yet"
    } -%}

  {%- endif -%}

  {{ data | json }}
  EOT
}
