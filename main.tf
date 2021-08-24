provider "aws" {
	default_tags {
	 tags = merge(var.tags, {
     owner       = "go"
		 se-region   = "apj"
		 purpose     = "demonstrations"
     ttl         = "-1"
		 terraform   = true
		 hc-internet-facing = true
   })
 }
}

data "aws_route53_zone" "main" {
  name = "hashidemos.io"
}

resource "aws_route53_zone" "aws_sub_zone" {
  for_each = toset(var.sub_zone)
  name    = each.value
  comment = "Delegated Sub Zone for AWS for go.hashidemos.io"
}

resource "aws_route53_record" "aws_sub_zone_ns" {
  for_each = toset(var.sub_zone)
  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value
  type    = "NS"
  ttl     = "30"

  records = [
    for zone in aws_route53_zone.aws_sub_zone[each.value].name_servers :
    zone
  ]
}

