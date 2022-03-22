control "iam_service_quotas_policies_per_group" {
    title = "IAM - Service Quota policies per group"
    description = "Examine service quotas on policies per group.  Will alarm at >50% utilization."
    sql = <<EOQ
with user_policy_quota as (
    select attached_policies_per_role_quota as quota
         , account_id
    from aws_iam_account_summary
)
select g.name                                                    as resource
     , jsonb_array_length(g.attached_policy_arns)                       as policy_count
     , jsonb_array_length(g.attached_policy_arns) / upq.quota::float4   as quota_percent
     , 'alarm'                                                   as status
     , g.name || ' has used ' || jsonb_array_length(g.attached_policy_arns) || ' of ' || upq.quota as reason
     , g._ctx ->> 'connection_name'                                as connection_name
     , g.account_id
from aws_iam_group g
         left join user_policy_quota upq on upq.account_id = g.account_id
group by g.name,
         jsonb_array_length(g.attached_policy_arns),
         jsonb_array_length(g.attached_policy_arns) / upq.quota::float4,
         upq.quota,
         g._ctx ->> 'connection_name',
         g.account_id
having jsonb_array_length(attached_policy_arns) / upq.quota::float4 > (upq.quota / 2);

    EOQ
}

