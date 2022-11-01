import boto3
client = boto3.client('iam',aws_access_key_id="AKIASELM5PMNK5NVCS7D",aws_secret_access_key="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") 

users = client.list_users()
user_list = []
for key in users['Users']:
    result = {}
    Policies = []

    result['userName']=key['UserName']
    List_of_Policies =  client.list_attached_user_policies(UserName=key['UserName'])

    result['Policies'] = List_of_Policies['AttachedPolicies']
 
    user_list.append(result)

for key in user_list:
    print(key)
