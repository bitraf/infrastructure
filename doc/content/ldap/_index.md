# Useful commands

Set up:

    ldap_host="-x -H ldap://p2k16-staging.bitraf.no"
    ldap_bind_admin="-D cn=admin,dc=test,dc=bitraf,dc=no -w admin"
    ldap_bind="-D cn=p2k16-web,dc=test,dc=bitraf,dc=no -w p2k16-web"
    ldap_base="dc=bitraf,dc=no"

Unauthenticated search:

    ldapsearch $ldap_host -b $ldap_base '(uid=trygvis)'

Authenticated search (admin)

    ldapsearch $ldap_host $ldap_bind_admin -b $ldap_base '(uid=trygvis)'

Authenticated search (p2k16-web)

    ldapsearch $ldap_host $ldap_bind -b $ldap_base '(uid=trygvis)'

# Initialization

The ansible playbook til generate a init.tmp.ldif

    scp ldap/env-test.tmp/* p2k16-staging.bitraf.no:

    docker exec -i ldap_ldap_1 ldapadd -D cn=admin,cn=config -w config -x -v < ~/init-01.ldif
    docker exec -i ldap_ldap_1 ldapadd -D cn=admin,dc=test,dc=bitraf,dc=no -w admin -x -v < ~/init-01.ldif

    ldapsearch -x -H ldap://p2k16-staging.bitraf.no -D cn=p2k16-web,dc=test,dc=bitraf,dc=no -w p2k16-web -b dc=test,dc=bitraf,dc=no "(objectClass=*)"

# See also

* https://www.digitalocean.com/community/tutorials/how-to-configure-openldap-and-perform-administrative-ldap-tasks
