# DMI Compliance and Control Framework

## Overview
[Dunder Mifflin Paper Company, Inc](https://en.wikipedia.org/wiki/Dunder_Mifflin) is the world leader in credit and banking.  

DMI defines its own compliance framework to ensure security and regulatory compliance.  This compliance framework provides a set of prescriptive controls for network and data security, user authentication and authorization, and monitoring. 

While Turbot provides capabilities to meet most of DMI's control objectives, DMI would like to be able to search, filter, and report on compliance to their specific controls using the Turbot console.  DMI employees are already aware of the DMI framework, and they communicate using the terms and definitions defined there.

To meet this requirement, DMI has decided to write a Turbot custom mod.  This mod will leverage existing Turbot resources and CMDB data but will present the data in the native structure of the DMI Control Framework.  Note that automated remediation ("enforce") is out of scope - these controls will be "check" mode only (existing Turbot controls can be used to remediate the items if desired, however)

## The DMI Compliance and Control Framework

The Dunder Mifflin Compliance and Control Framework (DMI CCF) is composed of a set of generalized controls, with separate implementations (benchmarks) that provide specific technical implementations for each technology platform.

Each platform has it's own mod, [dmi-ccf-aws](dmi-ccf-aws) for example, and there is also a common mod, called [dmi-ccf](dmi-ccf), which contains the root Dunder Mifflin policy type and common benchmark categories.

## Usage

Currently, DMI Compliance and Control Framework is composed of the following mods:

* [dmi-ccf](dmi-ccf/README.md): Root policy and common categories
* [dmi-ccf-aws](dmi-ccf-aws/README.md): Control Framework for AWS

Each mod has it's installation and usage instruction, but note that the [dmi-ccf](dmi-ccf/README.md) mod should be installed first as other mods depends on it.
