-- get a list of all users with two Active access keys
select user_name as resource
     , count(*)  as key_count
     , ARRAY( select access_key_id from aws_iam_access_key ik where ik.user_name = ak.user_name )::text[] as access_keys
     , 'alarm' as status
     , user_name || ' has two access keys' as reason
     , _ctx ->> 'connection_name' as connection_name
     , account_id
from aws_iam_access_key ak
where status = 'Active'
group by user_name, access_keys, status, connection_name, account_id
having count(*) > 1;

--
-- select ARRAY(select access_key_id as access_keys
-- from test_aab.aws_iam_access_key
-- where status = 'Active'
--     group by access_keys, user_name)::text[] as keys
--
-- select user_name,
--        access_key_id
-- from test_aab.aws_iam_access_key
-- order by user_name asc;
--
-- select user_name,
--        ARRAY( select access_key_id from test_aab.aws_iam_access_key aab where aab.user_name = test.user_name )::text[] as access_keys
-- from test_aab.aws_iam_access_key test
-- order by user_name asc;