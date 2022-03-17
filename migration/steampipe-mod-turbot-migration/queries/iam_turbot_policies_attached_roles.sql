select (regexp_match(policy_arn, '.*/(\w*)$'))[1]                  as resource
     , roles ->> 'RoleName'                                        as policy_role
     , 'alarm'                                                     as status
     , 'Turbot policy '
           || (regexp_match(policy_arn, '.*/(\w*)$'))[1]
           || ' is attached to non-Turbot managed role ' || r.name as reason
     , pol.account_id
     , pol._ctx ->> 'connectionName'                               as connection_name
from aws_iam_policy_attachment pol
   , jsonb_array_elements(pol.policy_roles) as roles
         left join aws_iam_role r on r.role_id = roles ->> 'RoleId'
where is_attached
  and pol.policy_arn like '%/turbot/%'
  and pol.policy_arn not like '%/turbot_lockdown%'
  and r.path not like '%/turbot/%';