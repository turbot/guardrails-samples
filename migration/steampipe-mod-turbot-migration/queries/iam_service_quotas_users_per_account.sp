control "iam_service_quotas_users_per_account" {
    title = "IAM - Account Service Quotas for Users"
    description = "Evaluate if an AWS Account is approaching its IAM service quotas for users"
    sql = <<EOQ
    select r.account_id                                                                                     as resource,
       'alarm'                                                                                          as status,
       r.account_id || ' has used ' || r.users || ' of ' || r.users_quota || ' the account roles quota' as reason,
       r._ctx ->> 'connection_name'                                                                     as connection_name,
       r.account_id                                                                                     as account_id
from aws_iam_account_summary r
group by r.account_id, r.users, r.users_quota, r._ctx ->> 'connection_name', r.account_id
having count(*) > (r.users_quota / 2);
    EOQ
}
