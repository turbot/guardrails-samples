--Turbot managed user with nonTurbot attached policies.
-- Specifically avoids all the `turbot_lockdown_*` policies.
select name                                                    as resource,
       (regexp_match(attached_policies, '.*/(\w*)$'))[1] as policy_name,
       'alarm'                                                 as status,
       'Turbot user ' || name
           || ' has a non-Turbot policy ' || (regexp_match(attached_policies, '.*/(\w*)$'))[1] as reason,
       _ctx ->> 'connection_name'                               as connection_name,
        account_id
from aws_iam_user
         cross join jsonb_array_elements_text(attached_policy_arns) as attached_policies
where path like '%/turbot/%'
  and attached_policies not like '%/turbot/%lockdown%'
  and attached_policies not like '%/turbot/turbot_deny';