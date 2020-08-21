# GNB Compliance and Control Framework

## Overview
[Goliath National Bank (GNB)](http://www.goliathbank.com/) is the world leader in credit and banking.  

GNB defines its own compliance framework to ensure security and regulatory compliance.  This compliance framework provides a set of prescriptive controls for network and data security, user authentication and authorization, and monitoring. 

While Turbot provides capabilities to meet most of GNB's control objectives, GNB would like to be able to search, filter, and report on compliance to their specific controls using the Turbot console.  GNB employees are already aware of the GNB framework, and they communicate using the terms and definitions defined there.

To meet this requirement, GNB has decided to write a Turbot custom mod.  This mod will leverage existing Turbot resources and CMDB data but will present the data in the native structure of the GNB Control Framework.  Note that automated remediation ("enforce") is out of scope - these controls will be "check" mode only (existing Turbot controls can be used to remediate the items if desired, however)

## The GNB Compliance and Control Framework

The Goliath National Bank Compliance and Control Framework (GNB CCF) is composed of a set of generalized controls, with separate implementations (benchmarks) that provide specific technical implementations for each technology platform.

Each platform has it's own mod, [gnb-ccf-aws](gnb-ccf-aws) for example, and there is also a common mod, called [gnb-ccf](gnb-ccf), which contains the root Goliath policy type and common benchmark categories.

## Usage

Currently, GNB Compliance and Control Framework is composed of the following mods:

* [gnb-ccf](gnb-ccf/README.md): Root policy and common categories
* [gnb-ccf-aws](gnb-ccf-aws/README.md): Control Framework for AWS

Each mod has it's installation and usage instruction, but note that the [gnb-ccf](gnb-ccf/README.md) mod should be installed first as other mods depends on it.
