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

-- attached policies per user
-- attached policies per role: policy count > max - 2
-- service limit on policies per group
