with user_policy_quota as (
    select attached_policies_per_user_quota as quota
         , account_id
    from aws_iam_account_summary
)
select u.name                                                    as resource
     , jsonb_array_length(inline_policies)                       as policy_count
     , jsonb_array_length(inline_policies) / upq.quota::float4   as quota_percent
     , 'alarm'                                                   as status
     , u.name || ' has more than 80% of attached-policies quota' as reason
     , _ctx ->> 'connection_name'                                as connection_name
     , u.account_id
from aws_iam_user u
         cross join jsonb_array_elements_text(inline_policies) as inline_policies
         left join user_policy_quota upq on upq.account_id = u.account_id
group by u.name, jsonb_array_length(inline_policies), jsonb_array_length(inline_policies) / upq.quota::float4,
         _ctx ->> 'connection_name', u.account_id
having jsonb_array_length(inline_policies) / upq.quota::float4 > 0.8;

-- attached policies per user
-- attached policies per role: policy count > max - 2
-- service limit on policies per group