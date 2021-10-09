# resource "ldap_object_attributes" "foo" {
#   dn = "olcDatabase={1}mdb,cn=config"
# 
#   attributes = [
#     { olcAccess = <<-EOF
#         {0}
#         to attrs=userPassword,shadowLastChange
#         by self write
#         by dn="cn=admin,dc=bitraf,dc=no" write
#         by dn="uid=p2k16-web,dc=bitraf,dc=no" write
#         by anonymous auth
#         by * none
#         EOF
#     },
#     { olcAccess = <<-EOF
#         {1}
#         to *
#         by dn="cn=admin,dc=bitraf,dc=no" write
#         by dn="cn=p2k16-web,dc=bitraf,dc=no" write
#         by * read
#         by * none
#         EOF
#     }
#   ]
# }
