# Azure Networking / Prevent unapproved network configuration of load balancers.

## User Story
The cloud operations team would like to ensure that they can detect if any load balancers exist that allow communication on known unencrypted ports (e.g. ftp/21, http/80 and smtp/25).

## Implementation Details
This Terraform configuration for creating a smart folder and applying the `Azure> Load Balancer> Load Balancer> Approved` to "Check: Approved" and a calculated policy on `Azure> Load Balancer> Load Balancer> Approved> Usage`.  The Calculated policy sets the value to "Unapproved" when one of the specified ports are present in the NAT or Load Balancer front end or back end rules and sets the value "Approved" otherwise.

### Template Input (GraphQL)
The template input to a calculated policy is a GraphQL query.  In this case the query selects all of the front end and back end port values from the NAT and Load Balancer rules:
```graphql
 {
  resource {
    natrules: get(path: "inboundNatRules")
    lbr: get(path: "loadBalancingRules")
  }
}
```
### Template (Nunjucks)
The template itself is a [Nunjucks formatted template](https://mozilla.github.io/nunjucks/templating.html) with custom logic:

```nunjucks
  {% set badPorts = [80,21,25] %}{# editable array of ports to be blocked #}
  {% set badPortFound = "False" %}
  {%- for item in $.resource.natrules%}
    {% if item.backendPort in badPorts or item.frontendPort in badPorts%}
      {% set badPortFound = "True" %} 
    {% endif %}
  {% endfor %}
  {%- for item in $.resource.lbr%}
    {% if item.backendPort in badPorts or item.frontendPort in badPorts%}
      {% set badPortFound = "True" %} 
    {% endif %}
  {% endfor %}
  {% if badPortFound == "True" %} 
    "Not approved"
  {% else %}
    "Approved"
  {% endif %}
```

## Pre-requisites

To create the smart folder, you must have:
- [Terraform](https://www.terraform.io) Version 12
- [Turbot Terraform Provider](https://turbot.com/v5/docs/reference/terraform)
- Credentials Configured to connect to your Turbot workspace

## Running the Example

To run the Template:
- Navigate to the directory on the command line `cd azure_load_balancer_prohibited_ports`
- Run `terraform plan -var-file="default.tfvars"` and review the changes to be applied
- Run `terraform apply -var-file="default.tfvars"` to execute and apply the policy settings

> The template will run with the default values set in `default.tfvars`; however, you could create and set your own defaults using a `.tfvars` file that will override the existing files.