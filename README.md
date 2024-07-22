# Turbot Guardrails Samples

[![plugins](https://img.shields.io/badge/policy_packs-110-blue)](https://hub.guardrails.turbot.com/policy-packs?utm_id=gspreadme&utm_source=github&utm_medium=repo&utm_campaign=github&utm_content=readme) &nbsp;
[![slack](https://img.shields.io/badge/slack-2500-blue)](https://turbot.com/community/join?utm_id=gspreadme&utm_source=github&utm_medium=repo&utm_campaign=github&utm_content=readme) &nbsp;
[![maintained by](https://img.shields.io/badge/maintained%20by-Turbot-blue)](https://turbot.com?utm_id=gspreadme&utm_source=github&utm_medium=repo&utm_campaign=github&utm_content=readme)

Welcome to the **Turbot Guardrails Samples** repository! This repository contains sample Policy Packs and queries to help you get started with Turbot Guardrails, ensuring your cloud environments are secure, compliant, and well-governed. It provides teams using [Turbot Guardrails](https://turbot.com/guardrails) automation and configuration-as-code examples for effective management of Guardrails for their organization.

## Table of Contents

- [Turbot Guardrails Samples](#turbot-guardrails-samples)
  - [Table of Contents](#table-of-contents)
  - [Overview](#overview)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Policy Packs](#policy-packs)
  - [Baselines](#baselines)
  - [Queries](#queries)

## Overview

[Turbot Guardrails](https://turbot.com/guardrails) provides automated governance controls for your cloud environments, helping you enforce policies across AWS, Azure, and GCP. This repository contains Policy Packs and Queries that demonstrate how to configure and use Turbot Guardrails to achieve various security and compliance objectives.

## Getting Started

### Prerequisites

Before you begin, ensure you have met the following requirements:

- You have an active Guardrails workspace(s).
- You have the necessary permissions to create and manage policies in Guardrails.
- You have set up your cloud provider accounts (AWS, Azure, GCP) and imported them in your Guardrails workspace.

### Installation

Clone the repository to your local machine:

```bash
git clone https://github.com/turbot/guardrails-samples.git
cd guardrails-samples
```

## Policy Packs

The `policy_pack` directory includes policy configurations for implementing common best practices for security, FinOps and compliance configured via Guardrails policy settings.  The Policy Packs are implemented with [Terraform](https://www.terraform.io), allowing you to manage and provision Guardrails with a repeatable, idempotent, versioned infrastructure-as-code approach.

## Baselines

The `baselines` directory provides a starting point for the most common configuration templates needed when creating a new Turbot Guardrails workspace or onboarding a cloud provider resource into Guardrails. Baselines are implemented with [Terraform](https://www.terraform.io), allowing you to manage and provision Turbot Guardrails with a repeatable, idempotent, versioned infrastructure-as-code approach.

## Queries

The `queries` directory contains GraphQL queries that can be run in your [Turbot Guardrails](https://turbot.com/guardrails) environment to assess compliance and security status of your cloud resources. These queries are designed to retrieve specific data points from your cloud environment, enabling you to enforce policies, generate reports, and monitor compliance. Each query is tailored to address a particular governance requirement or best practice.
