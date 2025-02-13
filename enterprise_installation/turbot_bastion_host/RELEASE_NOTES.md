# 1.4.0 (2025-02-11)

- IMDSv2 is now required, enhancing security by enforcing session-based metadata access.
- Integrated EC2 Launch Template to support IMDSv2 and streamline instance configurations.
- Added support for Graviton instance types, enabling cost-efficient ARM-based deployments.
- Expanded IAM permissions to include elasticache:Connect, allowing secure ElastiCache access.
- Updated default PostgreSQL client to version 16.x for improved database compatibility.

# 1.3.0 (2024-09-09)

- Defaults to Amazon Linux 2023 AMI.
- Comes with Postgresql 15.x client and Redis 6.x client

# 1.2.0 (2023-03-15)

- Add support for redis-cli v6.x from amazon-linux-extras.
- Removed EnvironmentVariables parameter from simplicity.

# 1.1.2 (2022-11-28)

- Add support for postgresql14 client installation from amazon-linux-extras.

# 1.1.1 (2021-08-30)

- Install postgresql12 and postgresql13 clients from amazon-linux-extras.

# 1.1.0 (2021-06-25)

- Choose between postgresql11, postgresql12 or postgresql13 client installation. Defaults to postgresql13.

# 1.0.0

**Added**

- Turbot Bastion Host initial template.
  - Eliminates the need for IAM users and SSH keys.
  - Eliminates the need for Inbound Security Group rules over port 22.
  - Grabs the latest Amazon Linux2 AMI using SSM Parameters.
  - Gives the ability to use custom configurations for AMIs and IAM Roles.
  - Self-destructs after the desired number of hours.
  - Comes with postgresql11 client installed.
