# Pre-Post IAM Comparisons
To verify that the account migration process was successful, let's look for differences in the IAM Groups and Users.

## Environment Config
- Queries running in some kind of `bash` shell-like environment.
- Configure `aws.spc` for the accounts of interest.  As shown below, Steampipe will blow away previous `pre_groups_users.csv`
- Configure `csv.spc` to point at the `data/` directory in this mod.  If running Steampipe in service-mode, be sure to restart the service after updating any `*.spc` files. 
- The name of the pre-migration CSV is hard-coded in the query.  It must be `pre_groups_users.csv`

When running `steampipe check all` will just be noisy.

1. Get Pre-migration groups and users
```shell
steampipe check control.iam_turbot_all_groups_all_users --header --output csv > data/pre_groups_users.csv
```
2. Perform the account migration
3. Compare Pre and Post by running:
```shell
steampipe check control.iam_turbot_all_groups_all_users --header --output csv > data/post_groups_users.csv
```
4. Resolve any discrepancies between Pre and Post.