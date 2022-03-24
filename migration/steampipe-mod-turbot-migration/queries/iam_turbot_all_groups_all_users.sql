--identify all turbot groups with turbot users in those groups
select name                            as group_name,
       iam_user ->> 'UserName'         as user_name,
       name                            as resource,
       'alarm'                          as status,
       name || ' group has ' || (iam_user ->> 'UserName')
           || ' Turbot user attached.' as reason,
       _ctx ->> 'connection_name'      as connection_name,
       g.account_id                    as account_id
from aws_iam_group g
         cross join jsonb_array_elements(users) as iam_user
where g.path like '%/turbot/%'
  and iam_user ->> 'Path' like '%/turbot/%';