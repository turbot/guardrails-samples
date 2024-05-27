# Runbook: Building a Folder Hierarchy

## Introduction

**Purpose**: This runbook guides Guardrails Administrators and Managed Service providers through the process of designing and implementing a smart folder strategy for a given Guardrails workspace.  The objective is to design and implement a simple and serviceable folder hierarchy. Greater complexity and categorization are possible.  This guide should serve as a baseline for discussions on more complex hierarchies. 

**Assumption**: This runbook assumes the Guardrails workspace is empty of folders and cloud accounts. 

## Key Ideas:
- **Common Policy Sets**: The Folder Hierarchy provides a set of convenient places to create policy settings that will apply to cloud accounts.
- **Scope of Policy Setting**: Where a policy setting is set (whether by direct attachment or smart folder attachment) in the resource hierarchy dictates how broadly it will apply.
- **Inspiration for Hierarchy**: The Guardrails Resource Hierarchy can be informed by, but is not bound to, any existing organizational hierarchy for cloud accounts. 
- **Shallower Hierarchies**: The Folder Hierarchy should be no deeper than necessary. Experience shows that one or two layers of folders below the Enterprise folder generally satisfies most organization's needs.
- **Adaptable Hierarchy**: The Folder Hierarchy can be changed as a later date to accommodate future requirement changes. 
- **Strategic Smart Folders** manage broadly applicable policies high in the resource hierarchy. They are generally attached once during initial workspace configuration.  Afterwards, policy settings in the smart folder are the only thing that changes.
- **Tactical Smart Folders** are meant to deal with specific, small scale scenarios; generally at the level of cloud accounts or smaller. Attached and detaching tactical smart folders is easy and fast. An easy example is a smart folder to hold all the policies that should be applied to a tombstoned cloud account. 

**Prerequisites**: 
-  **Credentials** Access to a Guardrails workspace with `Turbot/Admin` permissions or higher. 
- **Inventory of Organizational Attributes**:  What attributes can be used to categorize these accounts?  Some examples:
  - Business Unit
  - Environment
  - Cloud Platform
  - Application 
  - Security Requirements
  - Regulatory Requirements 
  - Network Segmentation


--- 

## Folder Hierarchy Procedure
1. Log into the Guardrails workspace. 
2. Create the Enterprise Folder.  This one folder will hold the rest of the resource hierarchy.  A common naming convention is "{Organization Name} Enterprise".
3. Create the Enterprise Smart Folder.  Attach this to the Enterprise Folder.  Any policies that apply to the entire enterprise should go in this smart folder. A common naming convention is "{Organization Name} Enterprise Policies". 
4. Decide on at most two attributes that will be used to categorize the cloud accounts.  The objective here is to answer the question: "How are we going to organize our policy settings, by account, by environment, by business unit?"    
   1. The most common attributes are "Business Unit", "Environment" and "Cloud Platform" are the most common attributes to sort cloud accounts.  Regulatory compliance is another example.    
   2. This runbook will use "Environment" and "Cloud Platform" as concrete examples.  Use any that are appropriate to the organization. 
5. Below the Enterprise folder, create folders for each value of the most important attribute. In this example, we will create folders named "AWS", "Azure" and "GCP", as our fictional organization utilizes all three cloud platforms.
6. Create smart folders that correspond to each Cloud Platform folder.  Attach each smart folder to the appropriate folder.  A common naming convention is "AWS Policies", "Azure Policies" or "GCP Policies".
7. Under each Cloud Platform Folder, create environment folders.  Common examples would be "Test", "NonProd" and "Prod".
8. Create Smart Folders for each environment folder and attach them to the target smart folder.
9. Use the `FolderHierarchy` GraphQL [query](#folderhierarchy-query) to retrieve the resource IDs for your folders.  This will help with automated cloud account imports.  
10. Import cloud accounts as desired.

### Finished Product
The below folder structure represents a possible folder hierarchy for a two attribute Folder Hierarchy. 
```
Turbot 
   "{Customer} Enterprise Policies" Smart Folder
      "{Customer} Enterprise" Folder
         "AWS Policies" Smart Folder
            "AWS" Folder
              "AWS Prod Policies" Smart Folder
                "AWS Prod" Folder
              "AWS NonProd Policies" Smart Folder
                "AWS NonProd" Folder
              "AWS Dev Policies" Smart Folder
                "AWS Dev" Folder                           
         "Azure Policies" Smart Folder
            "Azure" Folder
              "Azure Prod Policies" Smart Folder
                "Azure Prod" Folder
              "Azure NonProd Policies" Smart Folder
                "Azure NonProd" Folder
              "Azure Dev Policies" Smart Folder
                "Azure Dev" Folder
         "GCP Policies" Smart Folder
            "GCP" Folder
              "GCP Prod Policies" Smart Folder
                "GCP Prod" Folder
              "GCP NonProd Policies" Smart Folder
                "GCP NonProd" Folder
              "GCP Dev Policies" Smart Folder
                "GCP Dev" Folder
```


---

## Discussion
### Guardrails Managed IAM for AWS
In cases where the customer uses Guardrails-managed IAM and wishes to utilize User Mod and Role Mode, it's best to create an account folder that hold exactly one account. This allows role-role permission assignments to be granted by assigning them to the account folder.  User-mode permissions assignments can be granted on the AWS account itself. Using the above example, the folder hierarchy for such an AWS account:
`Turbot > {Customer} Enterprise > AWS > Prod > Web Farm (folder) > 12345678901 (AWS Account)`

### Account Import into Account Folder
The most reliable account import process uses account folders and `Turbot IAM Role [> *]` to prepare the workspace before account import.  Create an account folder.  On the account folder, set the `AWS > Account > Turbot IAM Role` and `AWS > Account > Turbot IAM Role > External ID` policy settings.  This ensures that the credentials policy settings are ready on account import.    

### Other Common Approaches
The common approaches can be used individually or combined to meet customer needs.  These are not prescriptive. If the approach fits your needs, use it.

- **Single Enterprise Smart Folder**: Create a Folder just below the Turbot resource that represents the entire enterprise.  Create a Smart Folder at the Turbot level with a name like "{Company} Enterprise Policies" (CEP).  Attach the CEP smart folder to the Enterprise folder.  Any policy that applies to the entire enterprise will go into the CEP smart folder.
```
Turbot 
   {Customer} Enterprise Policies Smart Folder
      {Customer} Enterprise Folder
```

- **Cloud Platform Smart Folders**: Just below the enterprise folder, it is common to create folders specific for each cloud platform that Turbot will manage.
```
Turbot 
   "{Customer} Enterprise Policies" Smart Folder
      "{Customer} Enterprise" Folder
         "AWS Policies" Smart Folder
            "AWS" Folder
         "Azure Policies" Smart Folder
            "Azure" Folder
         "GCP Policies" Smart Folder
            "GCP" Folder
```

- **Business Unit Folders**: Organize the folder hierarchy by business units. 

```
Turbot 
   {Customer} Enterprise Policies Smart Folder
      {Customer} Enterprise Folder
        "Sales" Smart Folder
            Sales Folder
        "R&D" Smart Folder
            R&D Folder
        "Manufacturing" Smart Folder
            Manufacturing Folder
        "Marketing" Smart Folder
            Marketing Folder
```

- **Environment Folders**: Many enterprises require that Guardrails policy settings graduate up through the lower environments before applying them to Prod.  The below folder structure reflects this requirements. 

```
Turbot 
   {Customer} Enterprise Policies Smart Folder
      {Customer} Enterprise Folder
         Test Policies Smart Folder
            Test Folder
         NonProd Policies Smart Folder
            NonProd Folder
         Staging Polic`ies Smart Folder
            Staging Folder
         Production Policies Smart Folder
            Production Folder
```

## Reference
### FolderHierarchy Query
```graphql
query FolderHierarchy {
  resources(
    filter: "resourceTypeId:'tmod:@turbot/turbot#/resource/types/folder' limit:200"
  ) {
    metadata {
      stats {
        total
      }
    }
    items {
      title
      turbot {
        id
      }
      parent {
        turbot {
          id
        }
      }
    }
    paging {
      previous
      next
    }
  }
}

```

## Conclusion

**Summary**: You have successfully created a Folder Hierarchy and Smart Folder Strategy.

**Next Steps**: Start to import cloud accounts into the proper folders. 
