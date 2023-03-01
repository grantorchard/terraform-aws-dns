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

resource "aws_route53_zone" "this" {
  name = "go.aws.hashidemo.io"
}