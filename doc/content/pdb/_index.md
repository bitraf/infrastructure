---
date: "2021-08-21"
title: Pdb
weight: 3
hide:
- nextpage
---

## Pdb - Bitraf's PostgreSQL service

## Useful commands

Getting `psql` console:

    docker exec -it pdb-p2k16_postgres_1 psql $db

Doing a `pg_dump`:

    docker exec -i pdb-p2k16_postgres_1 \
        postgres pg_dump --format custom --file /tmp/foo.pgdump foo 

Doing a `pg_restore`:

    docker exec -i pdb-p2k16_postgres_1 \
        pg_restore -U postgres --clean --verbose --format=custom -1 -d foo \
        /dev/stdin < ~trygvis/p2k16.pgdump


