select policy_arn as resource
     , groups ->> 'GroupName' as policy_group
     , g.path
     , g.name
     , 'alarm' as status
     , 'Turbot policy ' || policy_arn || ' is attached to non-Turbot managed group ' || g.name as reason
from aws_iam_policy_attachment pol
   , jsonb_array_elements(pol.policy_groups) as groups
         left join aws_iam_group g on g.group_id = groups ->> 'GroupId'
where is_attached
  and policy_arn like '%/turbot/%'
    and pol.policy_arn not like '%/turbot_lockdown%'
  and g.path not like '%/turbot/%';