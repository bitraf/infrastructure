# Configure Mosquitto

    ansible-playbook bomba.yml --tags mosquitto-server

More roles are specified for bomba elsewhere:
- ../all.yml: riemann-health
- ../all.yml: unattended-upgrades
- ../postfix.yml: postfix-satellite
