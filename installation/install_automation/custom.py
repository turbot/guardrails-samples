def get_config():
  return {
    "install_prefix": "turbot",
    ## TEF
    "tef_version"   : "v1.34.1",
    "alpha_region"  : "us-east-1",
    "vpc_id"        : "vpc-xxx",
    "web_subnets"   : "subnet-xxx,subnet-xxx",
    "app_subnets"   : "subnet-xxx,subnet-xxx",
    "db_subnets"    : "subnet-xxx,subnet-xxx",
    "oia_sg_id"     : "sg-xxx",   
    "alb_sg_id"     : "sg-xxx",   
    "api_sg_id"     : "sg-xxx",   
    "install_domain": "sandbox.amazon.biogen.com",
    "vpc_cidr"      : "10.241.11.0/24",
    "client_cidr"   : "0.0.0.0/0",
    "ldap_cidr"     : "10.0.0.0/8",
    "acm_cert_arn"  : "", 
    "alb_scheme"    : "internal",
    "api_gateway"   : "Enabled",
    "os_guardrails" : "ansible",
    "flags"         : "LDAP",       
    ## TED
    "ted_version"   : "v1.21.1",
    "hive_name"     : "edison",
    "db_type"       : "db.m6g.4xlarge",
    "db_failover"   : "false",
    "perf_insights" : "false",
    "cache_type"    : "cache.m5.large",
    "tags": [
        {
            'Key': 'Application',
            'Value': 'Turbot5'
        },
        {
            'Key': 'Environment',
            'Value': 'Sandbox'
        },
        {
            'Key': 'Business Unit',
            'Value': 'IAO'
        }
    ]
  }