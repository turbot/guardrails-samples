control "iam_service_quotas_roles" {
    title = "IAM - Service Quotas for role counts"
    description = "Examine AWS IMA Service Quotas for roles.  Will alarm when more than 80% of the quota is used."
    sql = <<EOQ
select roles
     , roles_quota
     , roles / roles_quota::float4               as quota_percent
     , account_id                                as resource
     , 'alarm'                                   as status
     , account_id || ' is greater than 80% used' as reason
     , _ctx ->> 'connection_name'                as connection_name
     , account_id
from aws_iam_account_summary
group by roles, roles_quota, roles / roles_quota::double precision, account_id, _ctx ->> 'connection_name'
having roles / roles_quota::float4 < 0.8;
    EOQ
}
