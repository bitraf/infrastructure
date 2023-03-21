Deploying p2k16
=====================

# Prerequisites

Follow ../README.md to set ansible and prepare for terraform.

Note that the following steps must be done on a machine that can reach the private network of Bitraf (10.13.37.0/24).

In the directory ops/terraform/p2k16-{production,staging}-db:

Run:

    terraform init
    terraform apply

This will create files in ops/terraform-output/ corresponding to the configuration and encrypted with ansible vault.

# Docker images

P2k16 is deployed with docker images stored on Gitlab registry. A dock image should be created corresponding to the branch name to deploy.

In case of a newer image is created with the same tag, e.g. master, the ansible playbook will not refresh the image automatically.

Log in to the machine p2k16/p2k16-staging.bitraf.no and run the following to update the docker images:

    cd /etc/docker-service/p2k16
    docker-compose pull
    docker-compose up -d

# Database migrations
Database migrations are done on the machine directly by checking out p2k16 from git and following the README.

Flyway is used and requires java. Download a jvm and put it in your PATH.

Set PGHOST to the internal IP of the p2k16 db and PGPORT to 5432. Run source .settings.sh
FLYWAY_PASSWORD must be set to the password found in ops/terraform-output/p2k16-$ENV-db/vault.json.

Verify that flyway works by running:

    flyway info

To update db run:

    flyway migrate

# How to deploy a new tag

Edit `svc-p2k16/host_vars/p2k16-$ENV/all.yml` and set `docker_tag` to the desired branch/tag name.

Run:

    ansible-playbook -l p2k16-$ENV svc-p2k16/app.yml
