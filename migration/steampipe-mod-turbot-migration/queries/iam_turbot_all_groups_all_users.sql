--identify turbot groups with non-Turbot users
select path                            as group_path,
       name                            as group_name,
       iam_user ->> 'Path'             as user_path,
       iam_user ->> 'UserName'         as user_name,
       g.account_id                    as account_id,
       _ctx ->> 'connection_name'      as connection_name,
       g.account_id                            as resource,
       'info'                          as status,
       name || ' group has '
           || (iam_user ->> 'UserName')
           || ' Turbot user attached.' as reason
from aws_iam_group g
         cross join jsonb_array_elements(users) as iam_user

where g.path like '%/turbot/%'
  and iam_user ->> 'Path' like '%/turbot/%';