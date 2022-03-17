with pre_groups_users as (
    select group_name, user_name, account_id
    from pre_groups_users
),
     post_groups_users as (
         select g.name                    as group_name,
                iam_user ->> 'UserName' as user_name,
                g.account_id            as account_id
         from aws_iam_group g
                  cross join jsonb_array_elements(users) as iam_user
         where g.path like '%/turbot/%'
           and iam_user ->> 'Path' like '%/turbot/%'
     )
select *
     , post.account_id as resource
      , 'alarm'                          as status
       , 'There is a mismatch between Pre and Post Gruops&Users' as reason
from pre_groups_users pre
         full outer join post_groups_users post
                    on pre.group_name = post.group_name
                        and pre.user_name = post.user_name
                        and pre.account_id = post.account_id
where pre.group_name is null or post.group_name is null
