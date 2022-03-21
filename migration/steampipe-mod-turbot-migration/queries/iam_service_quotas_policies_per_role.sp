control "iam_service_quotas_policies_per_role" {
    title = "IAM - Service Quota policies per role"
    description = "Examine service quotas on policies per role. Will alarm at >50% utilization."
    sql = <<EOQ
with user_policy_quota as (
    select attached_policies_per_role_quota as quota
         , account_id
    from aws_iam_account_summary
)
select r.name                                                    as resource
     , jsonb_array_length(r.attached_policy_arns)                       as policy_count
     , jsonb_array_length(r.attached_policy_arns) / upq.quota::float4   as quota_percent
     , 'alarm'                                                   as status
     , r.name || ' has used ' || jsonb_array_length(r.attached_policy_arns) || ' of ' || upq.quota as reason
     , r._ctx ->> 'connection_name'                                as connection_name
     , r.account_id
from aws_iam_role r
         left join user_policy_quota upq on upq.account_id = r.account_id
group by r.name,
         jsonb_array_length(r.attached_policy_arns),
         jsonb_array_length(r.attached_policy_arns) / upq.quota::float4,
         upq.quota,
         r._ctx ->> 'connection_name',
         r.account_id
having jsonb_array_length(attached_policy_arns) / upq.quota::float4 > (upq.quota / 2);
    EOQ
}
