# Pre-Post IAM Comparisons
To verify that the account migration process was successful, let's look for differences in the IAM Groups and Users.

## Environment Config
- Queries running in some kind of `bash` shell-like environment.  Variable interpolation works differently in `zsh`.
- Configure `aws.spc` for the accounts of interest.  As shown below, Steampipe will blow away previous `pre_groups_users.csv`
- Configure `csv.spc` to point at the `data/` directory in this mod.  If running Steampipe in service-mode, be sure to restart the service after updating any `*.spc` files.  Example: `$TDK_ROOT/migration/steampipe-mod-turbot-migration/**/*.csv`
- The Steampipe service should not be running.  It complicates caching behavior.

When running `steampipe check benchmark.pre`, you may need use `steampipe check benchmark.pre --var=account_id=$ACCOUNT_ID` instead.

1. Get Pre-migration groups and users.  (The use of `steampipe query` is intentional.  Using `steampipe check` returns extraneous data we don't need.)
```shell
mkdir -p data
export ACCOUNT_ID='ACCOUNT_ID_GOES_HERE'
steampipe query queries/iam_turbot_all_groups_all_users.sql --var=account_id=$ACCOUNT_ID --search-path-prefix $ACCOUNT_ID --header --output csv > data/pre_$ACCOUNT_ID.csv
```
2. Perform the account migration
3. Compare Pre and Post by running:
```shell
steampipe check control.iam_turbot_all_groups_all_users_post --var=account_id=$ACCOUNT_ID
```
Example:
```shell
export ACCOUNT_ID='test_aab'
steampipe check control.iam_turbot_all_groups_all_users_post --var=account_id=$ACCOUNT_ID
```

4. Resolve any discrepancies between Pre and Post.