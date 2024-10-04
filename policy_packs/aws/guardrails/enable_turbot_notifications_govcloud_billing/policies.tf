# AWS > Account > Budget > Enabled
resource "turbot_policy_setting" "aws_account_budget_enabled" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/accountBudgetEnabled"
  value    = "Check: Budget > State is On Target or below"
}

# AWS > Account > Budget > Target
resource "turbot_policy_setting" "aws_account_budget_limit" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws#/policy/types/accountBudgetLimit"
  value    = var.aws_account_budget_target
}

# Turbot > Notifications
resource "turbot_policy_setting" "turbot_notifications" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/notifications"
  value    = "Enabled"
  # value    = "Disabled"
}

# Turbot > Notifications > Rule-Based Routing
resource "turbot_policy_setting" "turbot_notifications_rule_based_routing" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/notificationsRuleBasedRouting"
  value    = <<-EOT
    [
      {
        "rules": "NOTIFY $.oldControl.state:ok $.control.state:alarm $.controlType.uri:'tmod:@turbot/aws#/control/types/budget'",
        "emails": ${jsonencode(split(",", var.email_ids))}
      }
    ]
    EOT
}

# Turbot > Notifications > Email > Control Template > Subject
resource "turbot_policy_setting" "turbot_notifications_email_control_template_subject" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/notificationsEmailControlTemplateSubject"
  value    = <<-EOT
    {% input %}
    query controlGet($id: ID!, $resourceId: ID!) {
      workspaceUrl: policyValue(uri: "tmod:@turbot/turbot#/policy/types/workspaceUrl", resourceId:$resourceId){
          value
        }
      aws_standard_govcloud_budget: resource(id:"aws_standard_govcloud_budget"){
          data 
        }
      resource {
        turbot {
          custom
        }
      }
      oldControl: control(id: $id) {
        state
        type {
          title
          trunk {
            title
          }
        }
        reason
        resource {
          type {
            title
          }
          metadata
          trunk {
            title
          }
        }
        turbot {
          updateTimestamp
          createTimestamp
        }
      }
    }

    {% endinput %}

    {%- set match_found = false -%}
    {%- for budget in $.aws_standard_govcloud_budget.data.budget_details -%}
    {%- if budget.standard_account_id == $.resource.turbot.custom.aws.accountId -%}
    {%- if not budget.govcloud_workspace or budget.govcloud_workspace != "NA" -%}
    {%- set govcloudworkspace = budget.govcloud_workspace -%}
    {% set workspace = govcloudworkspace.split('/')[2].split('.')[0] %}
    {%- set match_found = true -%}
    "[{{workspace}}] {% if $.oldControl.state == 'tbd' or $.oldControl.state == 'ok' %}{{ $.oldControl.state | upper }}{% else %}{{ $.oldControl.state | capitalize }}{% endif %} → {% if newControl.state == 'tbd' or newControl.state == 'ok' %}{{ newControl.state | upper }}{% else %}{{ newControl.state | capitalize }}{% endif %}: {{ $.oldControl.type.trunk.title }} for {{ budget.govcloud_trunk_title }} at {{ newControl.turbot.updateTimestamp }} UTC"
    {%- endif -%}
    {%- endif -%}{%- endfor -%}

    {%- if not match_found -%}
    {%- if domain %}
    {% set workspace = domain.split('/')[2].split('.')[0] %}
    "[{{workspace}}] {% if $.oldControl.state == 'tbd' or $.oldControl.state == 'ok' %}{{ $.oldControl.state | upper }}{% else %}{{ $.oldControl.state | capitalize }}{% endif %} → {% if newControl.state == 'tbd' or newControl.state == 'ok' %}{{ newControl.state | upper }}{% else %}{{ newControl.state | capitalize }}{% endif %}: {{ $.oldControl.type.trunk.title }} for {{ $.oldControl.resource.trunk.title }} at {{ newControl.turbot.updateTimestamp }} UTC"
    {%- else %}
    {% set workspace = "" %}
    "{% if $.oldControl.state == 'tbd' or $.oldControl.state == 'ok' %}{{ $.oldControl.state | upper }}{% else %}{{ $.oldControl.state | capitalize }}{% endif %} → {% if newControl.state == 'tbd' or newControl.state == 'ok' %}{{ newControl.state | upper }}{% else %}{{ newControl.state | capitalize }}{% endif %}: {{ $.oldControl.type.trunk.title }} for {{ $.oldControl.resource.trunk.title }} at {{ newControl.turbot.updateTimestamp }} UTC"
    {%- endif %}
    {%- endif %}

    EOT
}

# Turbot > Notifications > Email > Control Template > Body
resource "turbot_policy_setting" "turbot_notifications_email_control_template_body" {
  resource = "tmod:@turbot/turbot#/"
  type     = "tmod:@turbot/turbot#/policy/types/notificationsEmailControlTemplateBody"
  value    = <<-EOT
    {% input %}
    query controlGet($id: ID!, $resourceId: ID!, $filter: [String!]) {
      workspaceUrl: policyValue(uri: "tmod:@turbot/turbot#/policy/types/workspaceUrl", resourceId:$resourceId){
          value
        }
      aws_standard_govcloud_budget: resource(id:"aws_standard_govcloud_budget"){
          data 
        }
      resource {
        turbot {
          custom
        }
      }
      oldControl: control(id: $id) {
        actor {
          identity {
            picture
            turbot {
              title
              id
            }
          }
        }
        state
        reason
        details
        type {
          trunk {
            title
          }
        }
        turbot {
          createTimestamp
          updateTimestamp
          id
        }
        resource {
          turbot {
            id
          }
          trunk {
            title
          }
          type {
            title
          }
        }
      }
      quickActions: controlTypes(filter: $filter) {
        items {
          actionTypes{
            items{
              title
              icon
              description
              uri
              confirmationType
              defaultActionPermissionLevels
              turbot {
                id
              }
            }
          }
        }
      }
    }

    {% endinput %}

    <!DOCTYPE html>
    <html>
      <head>
          <meta charset="UTF-8">
          <title>Email Content</title>
      </head>
      <body>
          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0;">STANDARD RESOURCE</p>
          <p style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">
            <a style="color: #0000FF; text-decoration: none;" href="{{ domain }}/resources/{{$.oldControl.resource.turbot.id }}">{{ $.oldControl.resource.trunk.title | replace('>', '&gt;')}}</a>
          </p>

          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0;">GOVCLOUD RESOURCE</p>
          <p style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">
            <a style="color: #0000FF; text-decoration: none;" href="{%- set match_found = false -%}{%- for budget in $.aws_standard_govcloud_budget.data.budget_details -%}{%- if budget.standard_account_id == $.resource.turbot.custom.aws.accountId -%}{{ budget.govcloud_workspace }}/apollo/resources/{{ budget.govcloud_account_resource_id }}{%- set match_found = true -%}{%- endif -%}{%- endfor -%}{%- if not match_found -%}{%- endif %}">{%- set match_found = false -%}{%- for budget in $.aws_standard_govcloud_budget.data.budget_details -%}{%- if budget.standard_account_id == $.resource.turbot.custom.aws.accountId -%}{{ budget.govcloud_trunk_title | replace('>', '&gt;') }}{%- set match_found = true -%}{%- endif -%}{%- endfor -%}{%- if not match_found -%}""{%- endif %}</a>
          </p>

          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0; margin-top: 20px;">CONTROL</p>
          <p style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">
            <a style="color: #0000FF; text-decoration: none;" href="{{ domain }}/controls/{{$.oldControl.turbot.id }}">{{ $.oldControl.type.trunk.title | replace('>', '&gt;')}}</a>
          </p>
          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0; margin-top: 20px;">STATUS</p>
          <p style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">{% if $.oldControl.state == 'ok' %}OK{% elif $.oldControl.state == 'tbd'%}TBD{% else %}{{ $.oldControl.state | capitalize }}{% endif %}  → <span style="font-weight: bold; {% if newControl.state == 'alarm' or newControl.state == 'error' %}color: #CC0000;{% elif newControl.state == 'ok' %}color: #36a64f;{% else %}color: #d3d3d3;{% endif %}">{% if newControl.state == 'ok' %}OK{% elif newControl.state == 'tbd'%}TBD{% else %}{{ newControl.state | capitalize }}{% endif %}</span></p>
          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0; margin-top: 20px;">REASON</p>
          <p style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">{{ newControl.reason }}</p>
          {%- if $.quickActions.items and $.quickActions.items[0].actionTypes and $.quickActions.items[0].actionTypes.items.length > 0 %}
          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0; margin-top: 20px;">QUICK ACTIONS</p>
          <p style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">
            {% for item in $.quickActions.items[0].actionTypes.items -%}
            &rarr; <a style="color: #0000FF; text-decoration: none;" href="{{ domain }}/resources/{{ $.oldControl.resource.turbot.id }}?executeActionType={{ item.uri | replace('#', '%23')}}">{{ item.title }}</a><br>
            {% endfor -%}
          </p>
          {% endif -%}
          <p style="color: #999999; font-size: 10px; font-family: Arial, Helvetica, sans-serif; margin-bottom: 0; margin-top: 20px;">TIMESTAMP</p>
          <p  style="font-size: small; font-family: Arial, Helvetica, sans-serif; margin-top: 0;">{{ newControl.turbot.updateTimestamp }} UTC <a style="color: #0000FF; text-decoration: none;" href="{{ domain }}/processes/{{ process.id }}/logs?filter=logLevel%3A>%3Dinfo">[Log]</a></p>
          <div style="font-size: 11px; color: #848884; margin-top: 20px;">
            You have been subscribed to these email alerts by the system administrator of <a style="color: #0000FF; text-decoration: none;" href="{{ domain }}">{{ domain }}</a>. Please contact them directly for changes.
          </div>
      </body>
    </html>
    EOT
}
