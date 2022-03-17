--identify turbot users in non-Turbot groups
select name                               as user_name,
       iam_group ->> 'GroupName'          as group_name,
       name                               as resource,
       'alarm'                            as status,
       'Turbot user ' || name || ' is a member of non-Turbot managed group '
           || (iam_group ->> 'GroupName') as reason,
       u._ctx ->> 'connection_name'       as connection_name,
       u.account_id                       as account_id
from aws_iam_user u
         cross join jsonb_array_elements(groups) as iam_group
where u.path like '%/turbot/%'
  and iam_group ->> 'Path' not like '%/turbot/%';