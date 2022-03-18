with user_policy_quota as (
    select attached_policies_per_role_quota as quota
         , account_id
    from aws_iam_account_summary
)
select r.name                                                    as resource
     , jsonb_array_length(r.attached_policy_arns)                       as policy_count
     , jsonb_array_length(r.attached_policy_arns) / upq.quota::float4   as quota_percent
     , 'alarm'                                                   as status
     , r.name || ' has more than 80% of attached-policies quota' as reason
     , _ctx ->> 'connection_name'                                as connection_name
     , r.account_id
from aws_iam_role r
         left join user_policy_quota upq on upq.account_id = r.account_id
group by r.name, jsonb_array_length(attached_policy_arns), jsonb_array_length(attached_policy_arns) / upq.quota::float4,
         _ctx ->> 'connection_name', r.account_id
having jsonb_array_length(attached_policy_arns) / upq.quota::float4 > 0.8;

-- attached policies per user
-- attached policies per role: policy count > max - 2
-- service limit on policies per group