# Turbot Guardrails Samples

[![policy packs](https://img.shields.io/badge/policy_packs-143-blue)](https://hub.guardrails.turbot.com/policy-packs?utm_id=gspreadme&utm_source=github&utm_medium=repo&utm_campaign=github&utm_content=readme) &nbsp;
[![slack](https://img.shields.io/badge/slack-2500-blue)](https://turbot.com/community/join?utm_id=gspreadme&utm_source=github&utm_medium=repo&utm_campaign=github&utm_content=readme) &nbsp;
[![maintained by](https://img.shields.io/badge/maintained%20by-Turbot-blue)](https://turbot.com?utm_id=gspreadme&utm_source=github&utm_medium=repo&utm_campaign=github&utm_content=readme)

This repository contains sample Policy Packs and queries to help you get started with Turbot Guardrails, ensuring your cloud environments are secure, compliant, and well-governed. It provides teams using [Turbot Guardrails](https://turbot.com/guardrails) automation and configuration-as-code examples for effective management of Guardrails for their organization.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have an active Guardrails workspace.
- You have the necessary permissions to create and manage policies in Guardrails.
- You have set up your cloud provider accounts (AWS, Azure, GCP) and imported them in your Guardrails workspace.

### Usage

Clone:

```bash
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples
```

Please see each directory's README that contains specific usage instructions.

### API Examples

The [api_examples](https://github.com/turbot/guardrails-samples/tree/main/api_examples) directory includes working examples of how to call the Guardrails GraphQL API using Python and Javascript (node.js), this can serve a starting point for developing your own scripts or integrations.

### Baselines

The [baselines](https://github.com/turbot/guardrails-samples/tree/main/baselines) directory provides a starting point for the most common configuration templates needed when creating a new Turbot Guardrails workspace or onboarding a cloud provider resource into Guardrails. Baselines are implemented with [Terraform](https://www.terraform.io), allowing you to manage and provision Turbot Guardrails with a repeatable, idempotent, versioned infrastructure-as-code approach.

### Enterprise Installation

The [enterprise_installation](https://github.com/turbot/guardrails-samples/tree/main/enterprise_installation) directory contains some common (and uncommon) helpers that are sometimes used as part of complex enterprise installations of Guardrails. Guardrails support or professional services will direct you to use these when needed for your install.

### Guardrails Utilities

The [guardrails_utilities](https://github.com/turbot/guardrails-samples/tree/main/guardrails_utilities) directory contains useful scripts and utilities for common guardrails support operations (both enterprise and SaaS). Guardrails support or professional services will direct you to use these when needed.

### Mod Examples

The [mod_examples](https://github.com/turbot/guardrails-samples/tree/main/mod_examples) directory contains a working example of a custom mod that can serve as the basis for writing your own custom integration for Turbot Guardrails.

### Policy Packs

The [policy_packs](https://github.com/turbot/guardrails-samples/tree/main/policy_packs) directory includes policy configurations for implementing common best practices for security, FinOps and compliance configured via Guardrails policy settings.  The Policy Packs are implemented with [Terraform](https://www.terraform.io), allowing you to manage and provision Guardrails with a repeatable, idempotent, versioned infrastructure-as-code approach.

### Queries

The [queries](https://github.com/turbot/guardrails-samples/tree/main/queries) directory contains GraphQL queries that can be run in your [Turbot Guardrails](https://turbot.com/guardrails) environment to assess compliance and security status of your cloud resources. These queries are designed to retrieve specific data points from your cloud environment, enabling you to enforce policies, generate reports, and monitor compliance. Each query is tailored to address a particular governance requirement or best practice.

## Open Source & Contributing

This repository is published under the [Apache 2.0 license](https://www.apache.org/licenses/LICENSE-2.0). Please see our [code of conduct](https://github.com/turbot/.github/blob/main/CODE_OF_CONDUCT.md). We look forward to collaborating with you!

## Get Involved

**[Join #guardrails on Slack →](https://turbot.com/community/join)**

Want to help but not sure where to start? Pick up one of the `help wanted` issues:

- [Guardrails Samples](https://github.com/turbot/guardrails-samples/labels/help%20wanted)
