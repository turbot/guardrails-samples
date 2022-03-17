--identify turbot groups with non-Turbot users
select name                       as group_name,
       iam_user ->> 'UserName'    as user_name,
       name                       as resource,
       'alarm'                    as status,
       'group: ' || name
           || ' has non-Turbot user ' || (iam_user ->> 'UserName')
           || ' attached.'        as reason,
       _ctx ->> 'connection_name' as connection_name,
       g.account_id               as account_id
from aws_iam_group g
         cross join jsonb_array_elements(users) as iam_user
where g.path like '%/turbot/%'
  and iam_user ->> 'Path' not like '%/turbot/%';