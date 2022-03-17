select (regexp_match(policy_arn, '.*/(\w*)$'))[1] as resource
     , users ->> 'UserName'                       as policy_user
     , u.path                                     as user_path
     , u.name                                     as user_name
     , 'alarm'                                    as status
     , 'Turbot policy ' || (regexp_match(policy_arn, '.*/(\w*)$'))[1]
           || ' is attached to non-Turbot managed user '
    || u.name                                     as reason
     , pol.account_id
     , pol._ctx ->> 'connectionName'              as connection_name
from aws_iam_policy_attachment pol
   , jsonb_array_elements(pol.policy_users) as users
         left join aws_iam_user u on u.user_id = users ->> 'UserId'
where is_attached
  and policy_arn like '%/turbot/%'
  and pol.policy_arn not like '%/turbot_lockdown%'
  and u.path not like '%/turbot/%';
