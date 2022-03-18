-- get a list of all users with two Active access keys
select user_name as resource
     , count(*)  as key_count
      , ARRAY( select access_key_id from aws_iam_access_key ik where ik.user_name = ak.user_name and ik.account_id=ak.account_id)::text[] as access_keys
     , 'alarm' as status
     , user_name || ' has ' || count(*) || ' access keys' as reason
     , _ctx ->> 'connection_name' as connection_name
      , account_id
from aws_iam_access_key ak
where status = 'Active'
group by user_name,
          access_keys,
         status
         , connection_name
         , account_id
having count(*) > 1;