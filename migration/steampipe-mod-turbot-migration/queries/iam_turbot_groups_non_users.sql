--identify turbot groups with non-Turbot users
select path as group_path,
       name                    as group_name,
       iam_user ->> 'Path'     as user_path,
       iam_user ->> 'UserName' as user_name,
       name as resource,
       'alarm' as status,
       'group: ' || name || ' has non-Turbot users attached.' as reason
from aws_iam_group g
         cross join jsonb_array_elements(users) as iam_user
where g.path like '%/turbot/%'
  and iam_user ->> 'Path' not like '%/turbot/%';