# Controls Framework

This mod implements set of benchmark controls on the AWS platform to meet DMI Controls Framework standards

This mod is mainly comprised of [policies](https://turbot.com/v5/docs/concepts/policies) and 
[controls](https://turbot.com/v5/docs/concepts/controls), as the resources are defined, discovered, and updated by 
other Turbot mods.

This mod has dependencies, which are defined at [src/turbot.yml](src/turbot.yml) file. One of the dependencies is the 
common mod [dmi-ccf](../dmi-ccf) which should be installed first.


> The turbot-cli argument `--peer-path ../..` will be used here to map all the custom mods under the 
[@dmi](../README.md) folder

## Setting up local environment

Install and configure Turbot CLI by following [this guide](https://turbot.com/v5/docs/reference/cli/installation)


## Installing the mod

The turbot [install command](https://turbot.com/v5/docs/reference/cli/commands/install) installs a mod and all of its 
dependencies locally

``` bash
turbot install --peer-path ../..
```


## Inspecting

To inspect and verify the structure of the mod use the 
[turbot inspect command](https://turbot.com/v5/docs/reference/cli/commands/inspect)

``` bash
turbot inspect --peer-path ../..
```


## Testing

#### Running Unit tests

Running all tests:
``` bash
turbot test --peer-path ../..
```

Running tests of a specific control:
``` bash
turbot test --peer-path ../.. --control [control name]
```

## Uploading

Before deploying the mod, you first need to install its dependencies on the workspace.

First check mod dependencies at [src/turbot.yml](src/turbot.yml) file, then follow 
[this guide](https://turbot.com/v5/docs/guides/managing-mods/install-mods) to install them on the workspace.

After that, run the following command to upload the mod into the workspace defined in the local 
[Turbot CLI configuration file](https://turbot.com/v5/docs/reference/cli/installation#named-profiles), usually located 
at `[user home]/.turbot/config.yml`

``` bash
turbot up --peer-path ../.. --profile=[target workspace profile]
```
