control "iam_turbot_all_groups_all_users_post" {
    title = "IAM - Compare Pre Groups&Users with Post Groups&Users"
    description = "Compare the list of pre-migration groups and users with the groups and users currently in AWS.  See the Readme for more details on how to run this control."
#     sql = query.iam_turbot_all_groups_all_users_post.sql
sql = <<EOQ
with pre_groups_users as (
    select group_name,
           user_name,
           account_id
    from pre_${var.account_id}
),
     post_groups_users as (
         select g.name                       as group_name,
                iam_user ->> 'UserName'      as user_name,
                g._ctx ->> 'connection_name' as connection_name,
                g.account_id                 as account_id
                -- While specification of the table name is unusual, Steampipe will not find the right table if not specified.
         from ${var.account_id}.aws_iam_group g
                  cross join jsonb_array_elements(users) as iam_user
         where g.path like '%/turbot/%'
           and iam_user ->> 'Path' like '%/turbot/%'
     )
select pre.group_name
     , pre.user_name
     , post.group_name
     , post.user_name
     , post.group_name      as resource
     , 'alarm'              as status
     , case
           when pre.group_name is null and pre.user_name is null
--                     and post.group_name is not null and post.user_name is not null
               then post.user_name || ' was not found before the migration.'
           when post.group_name is null and post.user_name is null
--                     and pre.group_name is not null and pre.user_name is not null
               then pre.user_name || ' was not found after the migration.'
           else 'There is a mismatch between Pre and Post Gruops&Users'
    end                     as reason
--      , 'There is a mismatch between Pre and Post Gruops&Users' as reason
     , post.connection_name as connection_name
     , post.account_id      as account_id
from pre_groups_users pre
         full outer join post_groups_users post
                         on pre.group_name = post.group_name
                             and pre.user_name = post.user_name
                             and pre.account_id = post.account_id
where pre.group_name is null
   or post.group_name is null
EOQ
}

variable "account_id" {
    description = "Specify the Account ID to evaluate.  Must match the AWS profile specified in `aws.spc`"
    type = string
}