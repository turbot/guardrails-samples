#!/bin/bash

touch /etc/profile.d/load_env.log

cat > /etc/profile.d/load_env.sh << 'EOF'
#!/bin/bash
export ACCOUNT_ID=$(curl -s http://169.254.169.254/latest/meta-data/accountId)
export REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
export CFN_STACK_NAME="${stack_name}"
export TIME_TO_LIVE="${time_to_live}h"

if [ "$TIME_TO_LIVE" == "Do not delete the stack" ]; then
  echo "$(date): Stack will live forever young!"
else
  echo "$(date): Self destruct will be initiated in: $TIME_TO_LIVE"
  sleep $TIME_TO_LIVE && aws cloudformation delete-stack --stack-name $CFN_STACK_NAME
fi
EOF

nohup sh /etc/profile.d/load_env.sh >> /etc/profile.d/load_env.log 2>&1 &

source /etc/os-release
if [ "$VERSION_ID" == "2" ]; then
  amazon-linux-extras install -y postgresql14 redis6
elif [ "$VERSION_ID" == "2023" ]; then
  dnf install -y postgresql16.x86_64 redis6.x86_64
  ln -s /usr/bin/redis6-cli /usr/local/bin/redis-cli
else
  echo "Unsupported Linux distribution"
fi

cat > /usr/local/bin/db-connect.sh << 'EOF'
#!/bin/bash
AWS_REGION=$(aws configure get region)
if [ -z "$AWS_REGION" ]; then
  read -p "Please enter the AWS region: " AWS_REGION
fi

echo "Available RDS Instances in $AWS_REGION:"
aws rds describe-db-instances --query 'DBInstances[*].DBInstanceIdentifier' --output text --region $AWS_REGION

read -p "Enter the DBInstanceIdentifier to connect: " DBInstanceIdentifier
RDSHOST=$(aws rds describe-db-instances --db-instance-identifier "$DBInstanceIdentifier" --query 'DBInstances[0].Endpoint.Address' --output text --region $AWS_REGION)

export PGPASSWORD="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region $AWS_REGION --username turbot)"
psql -h $RDSHOST -d turbot -U turbot
EOF

chmod +x /usr/local/bin/db-connect.sh
