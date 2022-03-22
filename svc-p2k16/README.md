# How to deploy

Edit `svc-p2k16/host_vars/p2k16-$ENV/all.yml` and set `docker_tag` to the desired branch/tag name.

Run:

    ansible-playbook -l p2k16-$ENV svc-p2k16/app.yml
