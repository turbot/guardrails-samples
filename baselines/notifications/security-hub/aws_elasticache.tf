
resource "aws_elasticache_cluster" "example" {
  count                = var.enabled_caching ? 1 : 0
  cluster_id           = "turbot-firehose-to-sec-hub-cache"
  az_mode              = "single-az"
  engine               = "memcached"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name = "default.memcached1.6"
  port                 = 11211
  security_group_ids   = [aws_security_group.allow_memcached_to_lambda[0].id]
}
