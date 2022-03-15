-- get a list of all users with two Active access keys
select user_name as resource
     , count(*) as key_count
     , 'alarm'                             as status
     , user_name || ' has two access keys' as reason
from aws_iam_access_key
where status = 'Active'
group by user_name, status
having count(*) > 1;