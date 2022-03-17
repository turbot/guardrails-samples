select name                                                    as resource,
       'alarm'                                                 as status,
       'user: ' || name
           || ' is managed by Turbot and has inline policies.' as reason,

       _ctx ->> 'connection_name'                              as connection_name,
       account_id
from aws_iam_user
         cross join jsonb_array_elements_text(inline_policies) as inline_policies
where path like '%/turbot/%'
group by path, name, inline_policies, account_id, connection_name;
