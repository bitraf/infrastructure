p2k16.bitraf.no
===============

Apply ansible configuration
---------------------------

You need a superuser account on p2k16.
If you don't have one, ask one of the superusers for one.

For deploying the p2k16 application on staging (this is probably what you want):

```
ansible-playbook -l p2k16-staging --tags p2k16-main p2k16.yml --extra-vars 'p2k16__git_version=master'
```

To deploy a specific version (git commit, branch, or tag), replace `master` above.

For staging:

```
ansible-playbook -l p2k16-staging p2k16.yml
```

For prod:

```
ansible-playbook -l p2k16 p2k16.yml
```

Letsencrypt / HTTPS
===================

    certbot run --installer nginx -d p2k16.bitraf.no \
      --authenticator webroot \
      --webroot /var/www/p2k16.bitraf.no \
      --post-hook 'systemctl reload nginx'

https://github.com/certbot/certbot/issues/5405#issuecomment-356498627

See also
--------

- [p2k16.bitraf.no](http://p2k16.bitraf.no/)
- [bitraf wiki](https://bitraf.no/wiki/p2k16)
