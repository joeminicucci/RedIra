data "aws_route53_zone" "selected_dns_zone" {
  name  = var.domain
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.selected_dns_zone.zone_id
  name = element(keys(var.record), 0)
  type = var.type
  ttl = var.ttl
  records = [lookup(var.record, element(keys(var.record), 0))]
}

#amount can be utilized to pass in a large map of records for a particular type. This method is being retired for the above which is more simplistic
//resource "aws_route53_record" "record" {
//  count = var.amount
//
//  zone_id = data.aws_route53_zone.selected_dns_zone.zone_id
//  name = element(keys(var.records), count.index)
//  type = var.type
//  ttl = var.ttl
//  records = [lookup(var.records, element(keys(var.records), count.index))]
//}
