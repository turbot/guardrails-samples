--identify turbot groups with non-Turbot users
select account_id                        as resource,
       'alarm'                           as status,
       account_id || ' has ' || count(*) || ' roles.  It is may exceed the serivce quota' as reason,
       _ctx ->> 'connection_name'        as connection_name,
       g.account_id                      as account_id
from aws_iam_group g
group by account_id, _ctx ->> 'connection_name', g.account_id
having count(*) > 500;