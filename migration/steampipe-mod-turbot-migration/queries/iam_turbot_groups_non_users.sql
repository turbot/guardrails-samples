--identify turbot groups with non-Turbot users
select path                       as group_path,
       name                       as group_name,
       iam_user ->> 'Path'        as user_path,
       iam_user ->> 'UserName'    as user_name,
       _ctx ->> 'connection_name' as connection_name,
       g.account_id               as account_id,
       name                       as resource,
       'alarm'                    as status,
       'group: ' || name
           || ' has non-Turbot user ' || (iam_user ->> 'UserName')
           || ' attached.'        as reason
from aws_iam_group g
         cross join jsonb_array_elements(users) as iam_user
where g.path like '%/turbot/%'
  and iam_user ->> 'Path' not like '%/turbot/%';