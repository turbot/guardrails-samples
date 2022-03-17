--identify turbot users in non-Turbot groups
select path                               as user_path,
       name                               as user_name,
       iam_group ->> 'Path'               as group_path,
       iam_group ->> 'GroupName'          as group_name,
       name                               as resource,
       'alarm'                            as status,
       'Turbot user ' || name || ' is a member of non-Turbot managed group '
           || (iam_group ->> 'GroupName') as reason,
       u.account_id,
       u._ctx ->> 'connectionName'        as connection_name
from aws_iam_user u
         cross join jsonb_array_elements(groups) as iam_group
where u.path like '%/turbot/%'
  and iam_group ->> 'Path' not like '%/turbot/%';