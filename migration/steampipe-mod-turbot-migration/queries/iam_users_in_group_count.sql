-- get a list of all users that belong to more than 8 groups.
select au.name                                                                 as resource
     , jsonb_array_length(au.groups)                                           as group_count
     , 'alarm'                                                                 as status
     , au.name || ' belongs to ' || jsonb_array_length(au.groups) || ' groups' as reason
     , _ctx ->> 'connection_name'                                              as connection_name
     , account_id
from aws_iam_user au
where au.path like '%/turbot/%'
group by au.name
       , au.groups
       , au.name
       , connection_name
       , account_id
having jsonb_array_length(au.groups) > 8;