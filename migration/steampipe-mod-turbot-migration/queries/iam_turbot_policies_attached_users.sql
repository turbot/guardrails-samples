select policy_arn                              as resource
     , users ->> 'UserName'                    as policy_user
     , u.path
     , u.name
     , 'alarm'                                 as status
     , 'Turbot policy ' || policy_arn || ' is attached to non-Turbot managed user '
           || u.name || ' when it shouldnt be' as reason
from aws_iam_policy_attachment pol
   , jsonb_array_elements(pol.policy_users) as users
         left join aws_iam_user u on u.user_id = users ->> 'UserId'
where is_attached
  and policy_arn like '%/turbot/%'
  and policy_arn not like '%turbot_lockdown%'
  and u.path not like '%/turbot/%';