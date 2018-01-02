p2k16.bitraf.no
===============

Apply ansible configuration
---------------------------

You need a superuser account on p2k16.
If you don't have one, ask one of the superusers for one.

For staging:

```
ansible-playbook -l p2k16-staging p2k16.yml
```

For prod:

```
ansible-playbook -l p2k16 p2k16.yml
```

See also
--------

- [p2k16.bitraf.no](http://p2k16.bitraf.no/)
- [bitraf wiki](https://bitraf.no/wiki/p2k16)
