
select (regexp_match(policy_arn, '.*/(\w*)$'))[1] as resource
     , groups ->> 'GroupName' as policy_group
     , g.name
     , 'alarm' as status
     , 'Turbot policy ' || (regexp_match(policy_arn, '.*/(\w*)$'))[1]
           || ' is attached to non-Turbot managed group ' || g.name || ' when it shouldnt be' as reason
     , pol._ctx ->> 'connection_name' as connection_name
     , g.account_id
from aws_iam_policy_attachment pol
   , jsonb_array_elements(pol.policy_groups) as groups
         left join aws_iam_group g on g.group_id = groups ->> 'GroupId'
where is_attached
  and policy_arn like '%/turbot/%'
    and pol.policy_arn not like '%/turbot_lockdown%'
  and g.path not like '%/turbot/%';