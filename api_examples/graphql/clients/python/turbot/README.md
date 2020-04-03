# Turbot

Library that handles configuration management.
It will check for credentials in the following order

- Custom configuration
- Environment variables
- Turbot configuration

The library will also test to see if the end point is valid and will stop the script processing if invalid.

## Prerequisites

To run the scripts, you must have:

- [Python](https://www.python.org/) version 3 or above
- [Pip](https://pip.pypa.io/)

## Example

To use the library, you will need to include this to your **requirements.txt** file or copy the file in directly.

### Requirements file

To referencing the library can be done by adding relative paths to the **requirements.txt**

```
../turbot
```

### Referencing from script

Add the line

```python
import turbot
```

And for turbot to read the configuration details, the callee will need to send in a configuration file location and profile information.
Both this variables can be set to _None_

```python
config = turbot.Config(None, None)
config = turbot.Config(config_file, profile)
```
