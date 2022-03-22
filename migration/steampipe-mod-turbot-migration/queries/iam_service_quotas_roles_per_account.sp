control "iam_service_quotas_roles_per_account" {
    title = "IAM - Account Service Quotas for Roles"
    description = "Evaluate if an AWS Account is approaching its IAM service quotas for roles"
    sql = <<EOQ
select r.account_id                                                                                     as resource,
       'alarm'                                                                                          as status,
       r.account_id || ' has used ' || r.roles || ' of ' || r.roles_quota || ' the account roles quota' as reason,
       r._ctx ->> 'connection_name'                                                                     as connection_name,
       r.account_id                                                                                     as account_id
from aws_iam_account_summary r
group by r.account_id, r.roles_quota, r.roles, r._ctx ->> 'connection_name', r.account_id
having count(*) > (r.roles_quota / 2);
EOQ
}
