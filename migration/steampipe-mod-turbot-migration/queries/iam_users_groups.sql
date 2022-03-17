-- Enumerate all groups and member users.
select path                               as group_path,
       name                               as group_name,
       iam_user ->> 'UserName'            as user_name,
       iam_user ->> 'UserId'              as user_id,
       iam_user ->> 'PermissionsBoundary' as permission_boundary,
       iam_user ->> 'PasswordLastUsed'    as password_last_used,
       iam_user ->> 'CreateDate'          as user_create_date,
       _ctx ->> 'connection_name'          as connection_name,
        account_id
from aws_iam_group
         cross join jsonb_array_elements(users) as iam_user;