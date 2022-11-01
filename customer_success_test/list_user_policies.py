import boto3
client = boto3.client('iam',aws_access_key_id="AKIASELM5PMNK5NVCS7D",aws_secret_access_key="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") 

users = client.list_users()
print(users)

for key in users['Users']:
    List_of_Policies =  client.list_user_policies(UserName=key['UserName'])
    for key in List_of_Policies['PolicyNames']:
        print(key['PolicyName'])
