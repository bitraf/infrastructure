bite.bitraf.no
==============

apply ansible configuration
---------------------------

you need an account on bite, and be in the sudo group

```
ansible-playbook bite.yml
```

LXC
---

Creating a new container:

* Add an entry in `host_vars/bite/lxc.yml`.
* Run `ansible-playbook bite.yml`. This will create the container. It
  will also install all superuser's keys under /root/.ssh/authorized_keys.
* Create the Ansible play for the machine. Include the `lxc-guest`
  role. On the first run, use 
  `ansible-playbook $host.yml -e ansible_user=root`.

see also
--------

- [bitraf wiki](https://bitraf.no/wiki/Bite)
