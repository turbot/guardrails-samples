# GNB-CCF

This mod contains the root policy, the root control and common control categories. The sections are common to all platforms:

1. Authentication & Access Control
2. Data Security & Encryption
3. Network Security
4. Logging & Auditing
5. Data Protection & Business Continuity


## Control Categories
Categories provide an alternate, vendor agnostic view of controls and policies. The GNB category aligns with the Control Framework Categories, providing a view of all the controls and policies for all cloud providers - When GNB adds Azure and GCP controls to their framework, they will map to these same categories. The categories map each Turbot policy and control to a GNB Control Section.

- The top-level type is `Goliath`
- The next level is the GNB Control Section name that the item belongs to:
  - **Goliath > 1. Authentication & Access Control**
  - **Goliath > 2. Data Security & Encryption**
  - **Goliath > 3. Network Security**
  - **Goliath > 4. Logging & Auditing**
  - **Goliath > 5. Data Protection & Business Continuity**
- The GNB categories (as well as the root `Goliath` policy type) should be implemented in a separate `gnb-ccf` mod so that they can be shared by ALL benchmarks (`gnb-ccf-aws`, `gnb-ccf-azure`, etc). This mod must be installed first.


## Setting up local environment

Install and configure Turbot CLI by following [this guide](https://turbot.com/v5/docs/reference/cli/installation)


## Composing the mod
The [turbot compose](https://turbot.com/v5/docs/reference/cli/commands/compose) command resolve all inclusion directives starting from 'src/turbot.yml'

``` bash
turbot compose
```


## Inspecting

To inspect and verify the structure of the mod use the [turbot inspect command](https://turbot.com/v5/docs/reference/cli/commands/inspect)

``` bash
turbot inspect
```


## Testing

#### Running Unit tests

Running all tests:
``` bash
turbot test
```


## Uploading

Run the following command to upload the mod into the workspace defined in the local [Turbot CLI configuration file](https://turbot.com/v5/docs/reference/cli/installation#named-profiles), usually located at `[user home]/.turbot/config.yml`

``` bash
turbot up --profile=[target workspace profile]
```
