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
  target      = "v=spf1 a:bitraf.no ip4:85.90.244.199 ip4:77.40.158.113/27 ip6:2a01:7e01::f03c:91ff:fe67:e271 include:_spf.google.com ~all"
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
    "" : { type : "A", target : local.bitnode },
    "www" : { type : "A", target : local.bitnode },
    "bit" : { type : "A", target : "${local.pg4}.100", },
    "bitbot" : { type : "A", target : "127.0.0.1", },
    "bitnode" : { type : "A", target : "85.90.244.199", },
    "mail" : { type : "A", target : "85.90.244.199", },
    # "ns1": {type: "A", target: "85.90.244.199",},
    # "ns2": {type: "A", target: "85.90.244.199",},
    "www" : { type : "A", target : "85.90.244.199", },
    "api" : { type : "CNAME", target : "www.bitraf.no", },
    "staging" : { type : "CNAME", target : "www.bitraf.no", },
    "blog" : { type : "CNAME", target : "www.bitraf.no", },
    "scripts" : { type : "CNAME", target : "www.bitraf.no", },
    "shop" : { type : "CNAME", target : "www.bitraf.no", },
    "bix" : { type : "A", target : "77.40.158.100", },
    "james" : { type : "A", target : "77.40.158.101", },
    "bomba" : { type : "A", target : "77.40.158.113", },
    "bite" : { type : "A", target : "77.40.158.102", },
    # virtual machine on bite
    "heim" : { type : "A", target : "77.40.158.103", },
    "p2k16-test" : { type : "CNAME", target : "heim.bitraf.no", },
    # virtual machine on bite
    "p2k16-staging" : { type : "A", target : "77.40.158.104", },
    # virtual machine on bite
    "p2k16" : { type : "A", target : "77.40.158.105", },
    # virtual machine on bite
    "mqtt2" : { type : "A", target : "77.40.158.106", },
    # virtual machine on bite
    "iot2" : { type : "A", target : "77.40.158.107", },
    # virtual machine on bite
    "riemann" : { type : "A", target : "77.40.158.108", },
    "bitwarden" : { type : "CNAME", target : "bite.bitraf.no", },
    "minio" : { type : "AAAA", target : "2001:840:4b0b:1337:e8d9:2ff:fea1:7189", },
    "webapps" : { type : "CNAME", target : "bomba.bitraf.no", },
    "pulseaudio" : { type : "CNAME", target : "bomba.bitraf.no", },
    "mqtt" : { type : "CNAME", target : "bomba.bitraf.no", },
    "iot" : { type : "CNAME", target : "bomba.bitraf.no", },
    "openhab" : { type : "CNAME", target : "bomba.bitraf.no", },
    "openhab2" : { type : "CNAME", target : "bomba.bitraf.no", },
    "p2k12" : { type : "CNAME", target : "bomba.bitraf.no", },
    "door" : { type : "CNAME", target : "p2k12.bitraf.no", },
    "door2" : { type : "CNAME", target : "p2k12.bitraf.no", },
    "boxy4" : { type : "CNAME", target : "boxy4.local", },
    "wormwood" : { type : "A", target : "195.159.128.13", },
    "channon" : { type : "A", target : "178.79.163.96", },
  }
}

locals {
  pg4     = "77.40.158"
  bitnode = "85.90.244.199"
}
