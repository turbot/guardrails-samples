# Usage instructions
## Virtual environments activation
1. We recommend the use of [virtual environment](https://docs.python.org/3/library/venv.html).
To setup a virtual environment:

```shell
python3 -m venv .venv
```

Once created, to activate the environment:

```shell
source .venv/bin/activate
```
2. Install `click`, `py-dateutil` and `requests` with `pip3`:

   `pip install -r requirements.txt`  
   
3. Add required environment aliases to `workspaces.conf`.

   For each section, you will need the `workspaceURL`, `accessKey`, `secret` and optionally provide `verifySSL` (defaults to True if not passed in config)
   
4. Run the script as follows: `python3 get_workspace_usage.py -w <workspaceAlias> -s <startDate> -e <endDate>`

   e.g `python3 get_workspace_usage.py -w acme -s 20200501 -e 20200531`
   
5. The script will output the stats required to generate a bill.

   - We generate a text file with a summary in the format `<workspaceAlias>_<startDate>_<endDate>_control_usage.txt`.
   - We also generate a CSV file with a breakdown in the format `<workspaceAlias>_<startDate>_<endDate>_control_usage.csv`.

   - Use the optional -o parameter to generate the breakdown in json format: `python3 get_workspace_usage.py -w <workspaceAlias> -s <startDate> -e <endDate> -o json`

   e.g. `python3 get_workspace_usage.py -w acme -s 20200501 -e 20200531 -o json`

   The output will be in the json format for each usage period:

   {
      "licenseId": "[licenseId]",
      "workspaceId": "[workspaceId]",
      "period": "<period for which the usage is generated>",
      "control": {
         "version": "2020-07-22",
         "usage": [
            {
            "uri": "<control-type-uri>",
            "error": <error-count>,
            "alarm": <alarm-count>,
            "invalid": <invalid-count>,
            "ok": <ok-count>,
            "tbd": <tbd-count>,
            "skipped": <skipped-count>,
            "activeControlDays": <active-count>,
            "inactiveControls": <inactive-count>
            }
            ...
         ]
      }
   }
