--Turbot managed user with nonTurbot attached policies.
-- Specifically avoids all the `turbot_lockdown_*` policies.
select path,
       name as resource,
       attached_policies,
       'alarm' as status,
       'Turbot user ' || name || ' has an attached non-Turbot policy: ' || attached_policies as reason
from aws_iam_user
     cross join jsonb_array_elements_text(attached_policy_arns) as attached_policies
where path like '%/turbot/%'
and attached_policies not like '%/turbot/%lockdown%';