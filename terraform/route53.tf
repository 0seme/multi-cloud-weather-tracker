data "aws_route53_zone" "primary" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_health_check" "primary" {
  fqdn              = aws_s3_bucket_website_configuration.primary.website_endpoint
  port              = 80
  type              = "HTTP"
  resource_path     = "/"
  failure_threshold = 3
  request_interval  = 30

  tags = {
    Name    = "koko-weather-health-check"
    Project = "multi-cloud-weather-tracker"
  }
}

resource "aws_route53_record" "primary" {
  zone_id        = data.aws_route53_zone.primary.zone_id
  name           = "www.${var.domain_name}"
  type           = "CNAME"
  ttl            = 60
  set_identifier = "primary"
  records        = [aws_s3_bucket_website_configuration.primary.website_endpoint]

  failover_routing_policy {
    type = "PRIMARY"
  }

  health_check_id = aws_route53_health_check.primary.id
}

resource "aws_route53_record" "secondary" {
  zone_id        = data.aws_route53_zone.primary.zone_id
  name           = "www.${var.domain_name}"
  type           = "CNAME"
  ttl            = 60
  set_identifier = "secondary"
  records        = [trimsuffix(replace(azurerm_storage_account.dr.primary_web_endpoint, "https://", ""), "/")]

  failover_routing_policy {
    type = "SECONDARY"
  }
}