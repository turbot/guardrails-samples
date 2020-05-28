# Repository Tools

This section of the code is used for generating the `README.md` MarkDown files for the following example types:

- Calculated Policies

## Generate Calculated Policies Documentation

### Adding New Document

1. Navigate to the relative folder `./repo-tools/templates/calc-policy/` using the Terminal
2. Create a new child folder

> **Note:** The name of the folder should match the name of the Calculated Policy example

3. Add a new Calculated Policy Configuration file called `template.yml`

#### Configuration Schema

The Calculated Policy configuration schema:

```yaml
title:
  description: The main title for the calculated policy
  type: string

useCase:
  description: The description as to what problem the calculated policy is meant to solved
  type: string

detail:
  description: More descriptive details on how the calculated policy works
  type: string

templateInput:
  description: Configures the section of the documentation that deals with the template input query
  type: object
  required:
    - details
    - query
  properties:
    details:
      description: Further details about the template input code
      type: string
    query:
      description: The actual GraphQL query that is passed into the Turbot policy template input property
      type: string

template:
  description: Configures the section of the documentation that deals with the template logic
  type: object
  required:
    - details
    - source
  properties:
    details:
      description: Further details about the template logic code
      type: string
    source:
      description: The actual Nunjucks source that is passed into the Turbot policy template property
      type: string
```

### Run Document Generation

1. Navigate to the relative folder `./repo-tools/` using the Terminal
2. Run npm task calc-policies `npm run gen-doc:calc-policies`
