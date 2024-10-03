resource "linode_domain" "bitraf" {
  type      = "master"
  domain    = "bitraf.no"
  soa_email = "root@bitraf.no"
}

resource "linode_domain_record" "mx" {
  domain_id   = linode_domain.bitraf.id
  record_type = "MX"
  target      = each.key
  priority    = each.value

  for_each = {
    "ASPMX.L.GOOGLE.COM" : 1
    "ALT1.ASPMX.L.GOOGLE.COM" : 5
    "ALT2.ASPMX.L.GOOGLE.COM" : 5
    "ALT3.ASPMX.L.GOOGLE.COM" : 10
    "ALT4.ASPMX.L.GOOGLE.COM" : 10
  }
}

resource "linode_domain_record" "txt-records" {
  domain_id   = linode_domain.bitraf.id
  record_type = "TXT"
  target      = "Bitraffineriet"
}

resource "linode_domain_record" "spf" {
  domain_id   = linode_domain.bitraf.id
  record_type = "TXT"
  target      = "v=spf1 a:bitraf.no ip4:${local.bitnode} ip4:${local.bomba}/27 ip6:2a01:7e01::f03c:91ff:fe67:e271 include:_spf.google.com ~all"
}

resource "linode_domain_record" "libera-chat" {
  domain_id   = linode_domain.bitraf.id
  record_type = "TXT"
  target      = "lba-verify-982374234"
}

resource "linode_domain_record" "domainkey-1" {
  domain_id   = linode_domain.bitraf.id
  record_type = "TXT"
  name        = "_domainkey"
  target      = "t=y; o=~;"
}

resource "linode_domain_record" "domainkey-2" {
  domain_id   = linode_domain.bitraf.id
  record_type = "TXT"
  name        = "20131107._domainkey"
  target      = "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDSklEq7X0qZyRDvLMVNXf6MDHxIOl8PkeG4UiI3gBr0a4uI7GGsMtmMAG8YgQ50mhN9m0hx03qqCCPsKwhdtUkwShDAcM94EZ1bIuOcHqI4Fb+gRrwhFuU0nixuv1VYc3Rg45qNqk1Ep1W8vOqaUra2nNE7mXpqkDvbjK76UZO8QIDAQAB"
}

resource "linode_domain_record" "a-records" {
  domain_id   = linode_domain.bitraf.id
  record_type = each.value.type
  name        = each.key
  target      = each.value.target

  for_each = {
    "" : { type : "A", target : local.wpengine },
    "api" : { type : "CNAME", target : "www.bitraf.no", },
    "bitbot" : { type : "A", target : "127.0.0.1", },
    "bite" : { type : "A", target : local.bite, },
    "bitmart" : { type : "A", target : local.wpengine, },
    "bitnode" : { type : "A", target : local.bitnode, },
    "bit" : { type : "A", target : local.bit, },
    "bitwarden" : { type : "CNAME", target : "bite.bitraf.no", },
    "bix" : { type : "A", target : "77.40.158.100", },
    "blog" : { type : "CNAME", target : "www.bitraf.no", },
    "bomba" : { type : "A", target : local.bomba, },
    "channon" : { type : "A", target : "178.79.163.96", },
    "dlock" : { type : "A", target : "77.40.158.109", },
    "door2" : { type : "CNAME", target : "p2k12.bitraf.no", },
    "door" : { type : "CNAME", target : "p2k16.bitraf.no", },
    "heim" : { type : "A", target : "77.40.158.103", },
    "grafana" : { type : "A", target : "77.40.158.111", },
    #    "grafana" : { type : "AAAA", target : "2001:8c0:ea04:10:77:40:158:111", },
    "iot2" : { type : "A", target : "77.40.158.107", },
    "iot" : { type : "CNAME", target : "bomba.bitraf.no", },
    "healthchecks" : { type : "A", target : local.bite, },
    "james" : { type : "A", target : "77.40.158.101", },
    "kurs" : { type : "A", target : local.wpengine, },
    "mail" : { type : "A", target : local.bitnode, },
    "minio" : { type : "AAAA", target : "2001:840:4b0b:1337:e8d9:2ff:fea1:7189", },
    "mqtt2" : { type : "A", target : "77.40.158.106", },
    "mqtt" : { type : "CNAME", target : "bomba.bitraf.no", },
    "openhab2" : { type : "CNAME", target : "bomba.bitraf.no", },
    "openhab" : { type : "CNAME", target : "bomba.bitraf.no", },
    "p2k12" : { type : "CNAME", target : "bomba.bitraf.no", },
    "p2k16-production" : { type : "A", target : "77.40.158.110", },
    "p2k16-staging" : { type : "A", target : "77.40.158.104", },
    "p2k16-test" : { type : "CNAME", target : "heim.bitraf.no", },
    #    "p2k16" : { type : "A", target : "77.40.158.105", },
    "p2k16-old" : { type : "A", target : "77.40.158.105", },
    "p2k16" : { type : "A", target : "77.40.158.110", },
    "pulseaudio" : { type : "CNAME", target : "bomba.bitraf.no", },
    "riemann" : { type : "A", target : "77.40.158.108", },
    "scripts" : { type : "CNAME", target : "www.bitraf.no", },
    "shop" : { type : "CNAME", target : "www.bitraf.no", },
    "staging" : { type : "CNAME", target : "www.bitraf.no", },
    "testwiki" : { type : "A", target: "85.90.244.199", },
    "webapps" : { type : "CNAME", target : "bomba.bitraf.no", },
    "wiki" : { type : "A", target : local.bitnode, },
    "wormwood" : { type : "A", target : "195.159.128.13", },
    "www" : { type : "A", target : local.wpengine },
  }
}

locals {
  bit      = "77.40.158.100"
  bite     = "77.40.158.102"
  bitnode  = "85.90.244.199"
  bomba    = "77.40.158.113"
  wpengine = "34.89.223.2"
}
