resource "aws_elasticache_cluster" "latest_notification_cache" {
  count                = var.enabled_caching ? 1 : 0
  cluster_id           = "turbot-firehose-to-sec-hub-latest-cache"
  az_mode              = "single-az"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  subnet_group_name    = aws_elasticache_subnet_group.latest_notification_cache[0].name
  security_group_ids   = [local.security_group_id]

  tags = {
    "Company" = "Turbot"
    "Product" = "SecurityHubNotifier"
  }
}

resource "aws_elasticache_subnet_group" "latest_notification_cache" {
  count      = var.enabled_caching ? 1 : 0
  name       = "turbot-firehose-to-sec-hub-subnet-group"
  subnet_ids = [local.private_subnet_id]
}
