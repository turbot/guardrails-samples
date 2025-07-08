#!/bin/bash

# Detect the operating system version and install required packages
source /etc/os-release
if [ "$VERSION_ID" == "2" ]; then
  # Amazon Linux 2: Install PostgreSQL 14 and Redis 6 clients
  amazon-linux-extras install -y postgresql14 redis6
elif [ "$VERSION_ID" == "2023" ]; then
  # Amazon Linux 2023: Install PostgreSQL 16 and Redis 6 clients
  dnf install -y postgresql16.x86_64 redis6.x86_64
  # Create a symlink for redis-cli for compatibility
  ln -s /usr/bin/redis6-cli /usr/local/bin/redis-cli
else
  echo "Unsupported Linux distribution"
fi

# Create a helper script for connecting to RDS PostgreSQL instances
cat > /usr/local/bin/db-connect.sh << 'EOF'
#!/bin/bash
# This script is intended for interactive use by a user connected to the bastion host.
# It prompts for input and should not be run non-interactively.
# Prompt for AWS region if not set in AWS CLI config
AWS_REGION=$(aws configure get region)
if [ -z "$AWS_REGION" ]; then
  read -p "Please enter the AWS region: " AWS_REGION
fi

# List available RDS instances in the specified region
echo "Available RDS Instances in $AWS_REGION:"
DB_INSTANCES=$(aws rds describe-db-instances --query 'DBInstances[*].DBInstanceIdentifier' --output text --region $AWS_REGION)
echo "$DB_INSTANCES"

# If no DB instances are found, exit early
echo "$DB_INSTANCES" | grep -q '\S'
if [ $? -ne 0 ]; then
  echo "No RDS DBInstances found in region $AWS_REGION. Exiting."
  exit 0
fi

# Prompt user to select a DB instance to connect to
read -p "Enter the DBInstanceIdentifier to connect: " DBInstanceIdentifier
RDSHOST=$(aws rds describe-db-instances --db-instance-identifier "$DBInstanceIdentifier" --query 'DBInstances[0].Endpoint.Address' --output text --region $AWS_REGION)

# Generate an IAM authentication token and connect using psql
export PGPASSWORD="$(aws rds generate-db-auth-token --hostname $RDSHOST --port 5432 --region $AWS_REGION --username turbot)"
psql -h $RDSHOST -d turbot -U turbot
EOF

# Make the db-connect.sh script executable
chmod +x /usr/local/bin/db-connect.sh
