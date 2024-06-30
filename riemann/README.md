riemann
=======

to do
-----

- [ ] system user for riemann
- [ ] system user for riemann-health
- [ ] configuration parameter for riemann hostname

Apply ansible configuration
---------------------------

You need a superuser account on riemann.
If you don't have one, ask one of the superusers for one.

```
ansible-playbook -l riemann riemann.yml
```

If programs are built (`make`) then they will be pushed and installed.

See also
--------

- [bitraf wiki](https://bitraf.no/wiki/Nettverk)
