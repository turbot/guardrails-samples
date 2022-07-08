
terraform {
  required_providers {
    turbot = {
      source = "terraform-providers/turbot"
    }
  }
  required_version = ">= 0.13"
}

# Smart Folder Definition
resource "turbot_smart_folder" "gcp_computeengine_image" {
  title          = var.smart_folder_title
  description    = var.smart_folder_description
  parent         = var.smart_folder_parent_resource
}

# GCP > Compute Engine > Instance > Approved
resource "turbot_policy_setting" "gcp_computeengine_instance_approved" {
  resource = turbot_smart_folder.gcp_computeengine_image.id
  type     = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApproved"
  value    = "Check: Approved"
}

# GCP > Compute Engine > Instance > Approved > Custom
resource "turbot_policy_setting" "gcp_computeengine_instance_approved_custom" {
  resource       = turbot_smart_folder.gcp_computeengine_image.id
  type           = "tmod:@turbot/gcp-computeengine#/policy/types/instanceApprovedCustom"
  template_input = <<EOF
  - |
    {
      resource {
        rootDiskName: get(path: "disks[0].deviceName")
          # disks[].index: A zero-based index to this disk, where 0 is reserved for the boot disk.
          # If you have many disks attached to an instance, each disk would have a unique index number.
          # https://cloud.google.com/compute/docs/reference/rest/v1/instances
      }
    }
  - |
    {
      disks: resources(filter: "resourceTypeId:'tmod:@turbot/gcp-computeengine#/resource/types/disk' $.name:{{ $.resource.rootDiskName }} resourceTypeLevel:self"){
        items {
          sourceImage: get(path: "sourceImage")
          sourceImageId: get(path: "sourceImageId")
        }
      }
    }
  EOF
  template       = <<EOF
{# For a new instance that is just created, there is a fraction of delay for the volume to be upserted and the CMDB run to complete. #}
{# When the volumeCMDB is yet to finish but the instanceApproved is triggered, the second graphql query returns no results. #}
{# Ofcourse, once the volumeCMDB runs successfully and discovers the attributes sourceImage and sourceImageId, the approved control is triggered again. #}
{# Also, in extremely rare cases where the root disk is detached from the instance #}

{% if $.disks.items | length == 0 %}
- title: Image
  result: Not approved
  message: Unable to find the source Image details.
{%- elif $.disks.items[0].sourceImageId in ['4644004327634874935', '4801817364715522935']  %}
- title: Image
  result: Approved
  message: Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is approved for usage.
{% else %}
- title: Image
  result: Not approved
  message: Image {{ $.disks.items[0].sourceImage.split('/').pop() }} is not approved for usage.
{%- endif -%}
  EOF
  precedence     = "REQUIRED"
}