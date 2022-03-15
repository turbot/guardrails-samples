select policy_arn as resource
     , roles ->> 'RoleName' as policy_role
     , r.path
     , r.name
     , 'alarm' as status
     , 'Turbot policy ' || policy_arn || ' is attached to non-Turbot managed role ' || r.name || ' when it shouldnt be' as reason
from aws_iam_policy_attachment pol
   , jsonb_array_elements(pol.policy_roles) as roles
         left join aws_iam_role r on r.role_id = roles ->> 'RoleId'
where is_attached
  and pol.policy_arn like '%/turbot/%'
  and r.path not like '%/turbot/%';