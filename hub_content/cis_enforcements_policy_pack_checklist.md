# CIS Enforcement Smart Folder formatting checklist

1. Directory structure is organized by CSP, with a flat structure underneath for each major CIS section:

    cis_enforcements/
    └── aws/
        ├── cis_v300_s1_iam/
        ├── cis_v300_s2_storage/
        ├── cis_v300_s3_logging/
        ├── cis_v300_s4_monitoring/
        └── cis_v300_s5_networking/
    └── azure/
    └── gcp/

2. Standard Files: Each Smart Folder definition will contain a main.tf, common.tf, and README.MD.

├── cis_v300_s1_iam
    ├── README.md            -> Standard README (see Section 1 & 2)
    ├── common.tf            -> Smartfolder + service enabled settings
    ├── main.tf              -> Provider & Var Definitions
    └── {policy_type}.tf

3. Policy files: Each Smart Folder definition will contain one or more policy file `.tf` templates. These should be named to correspond to the resource types effected, ideally named after the CIS subsection when available. See examples in Sections 1 & 2, and keep it short.

4. Policy Settings
    - Policies should be preceded with a comment corresponding to the Guardrails policy trunk title.
    - Smart folder IDs should match the folder name e.g. `aws_cis_v300_s1_iam`
    - Use `terraform fmt` to adhere to the standard HCL style guide.
    - Order of fields:  
        1. resource
        2. type
        3. note
        4. value (if needed)
        5. template_input (if needed)
        6. template (if needed)
    - Notes should contain a short reference to the CIS control(s) they are associated with. e.g.: `"AWS CIS v3.0.0 - Controls: 1.10 & 1.11"`
    - multi-line strings should use the [indented heredoc](https://developer.hashicorp.com/terraform/language/expressions/strings#indented-heredocs) `<<-EOT` style.

5. Enforcement options standard policies:
    - All policies should be set initially to "Check: ..."
    - Add additional lines into the configuration representing any appropriate "Enforce: ..." options.
    - Comment out the "Enforce: ..." options using the code editor's auto comment function (Cmd-/ in VS Code).  This adds `#` in front of the first non-whitespace char in the line.  In this way when uncommented, the HCL will still align properly.

6. Enforcement options calc policies:
    - All calc policies should be set initially to "Check: ..."
    - Add hardcoded values for check and enforce options into the template input and comment out the enforcement option. e.g.:

        ```
        value: constant(value: "Check: Login profile enabled")
        # value: constant(value: "Enforce: Delete login profile")
        ```

    - Use `$.value` in the calc policy template where you would normally hardcode the policy value output. e.g.:

        ```
        {%- if (not has_mfa) or has_key -%}
        {{ $.value | json }}
        {%- else -%}
        ```  

7. Variables: Avoid the use of variables unless the same value would need to be repeated in multiple parts of a template.
