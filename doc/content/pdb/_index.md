---
date: "2021-08-21"
title: Pdb
weight: 3
hide:
- nextpage
---

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

## Restoring a database from backups

These instructions assume that you're running the commands from the
root of the infrastructure repository.  Make sure you have our wal-g
in your path, by running `. .settings.sh` in your shell.

Create access keys for the [Object Storage at Linode](https://cloud.linode.com/object-storage/access-keys):

  * Check "Limited Access", allow only the bucket you want to restore.
  * Label it something like "$user-pdb-restore"

Configure your environment:

    rm -rf tmp/envdir && mkdir tmp/envdir
    echo eu-central-1                             > tmp/envdir/AWS_REGION
    echo "https://eu-central-1.linodeobjects.com" > tmp/envdir/AWS_ENDPOINT
    echo s3://...                                 > tmp/envdir/WALG_S3_PREFIX
    echo ...                                      > tmp/envdir/AWS_ACCESS_KEY_ID
    echo ...                                      > tmp/envdir/AWS_SECRET_ACCESS_KEY

List all backups:

    envdir ./tmp/envdir wal-g backup-list

Fetch the latest backup:

    rm -rf tmp/pgdata
    envdir ./tmp/envdir wal-g backup-fetch tmp/pgdata LATEST

Sample output:

    INFO: 2021/09/07 09:58:15.592410 LATEST backup is: 'base_00000001000000000000003E'
    INFO: 2021/09/07 09:58:16.046776 Finished extraction of part_003.tar.lz4
    INFO: 2021/09/07 09:58:16.046824 Finished decompression of part_003.tar.lz4
    INFO: 2021/09/07 09:58:23.427719 Finished extraction of part_001.tar.lz4
    INFO: 2021/09/07 09:58:23.427757 Finished decompression of part_001.tar.lz4
    INFO: 2021/09/07 09:58:23.668054 Finished decompression of pg_control.tar.lz4
    INFO: 2021/09/07 09:58:23.668085 Finished extraction of pg_control.tar.lz4
    INFO: 2021/09/07 09:58:23.668098
    Backup extraction complete.

Configure postgresql.conf:

    sed '/restore_command/d' tmp/pgdata/postgresql.conf > tmp/pgdata/postgresql.tmp 
    cat - >> tmp/pgdata/postgresql.tmp <<EOF
    restore_command = '/pgdata/bin/envdir /envdir /pgdata/bin/wal-g wal-fetch "%f" "%p" >> /pgdata/wal.log 2>&1'
    EOF
    mv tmp/pgdata/postgresql.tmp tmp/pgdata/postgresql.conf

    echo -n > tmp/pgdata/wal.log
    touch tmp/pgdata/recovery.signal

Do the restore:

    docker run \
        --rm -it \
        --user $(id -u):$(id -g) \
        -e PGDATA=/pgdata \
        -v /etc/passwd:/etc/passwd \
        -v $(pwd)/bin:/pgdata/bin \
        -v $(pwd)/tmp/envdir:/envdir \
        -v $(pwd)/tmp/pgdata:/pgdata \
        --network=host \
        registry.gitlab.com/bitraf/infrastructure/docker-postgres:13 postmaster


Sample output:

    2021-09-07 07:59:40.512 UTC [1] LOG:  starting PostgreSQL 13.4 (Debian 13.4-1.pgdg100+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 8.3.0-6) 8.3.0, 64-bit
    2021-09-07 07:59:40.512 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
    2021-09-07 07:59:40.512 UTC [1] LOG:  listening on IPv6 address "::", port 5432
    2021-09-07 07:59:40.519 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
    2021-09-07 07:59:40.533 UTC [7] LOG:  database system was interrupted; last known up at 2021-09-07 03:45:01 UTC
    2021-09-07 07:59:41.306 UTC [7] LOG:  starting archive recovery
    2021-09-07 07:59:41.693 UTC [7] LOG:  restored log file "00000001000000000000003E" from archive
    2021-09-07 07:59:41.734 UTC [7] LOG:  redo starts at 0/3E000028
    2021-09-07 07:59:41.739 UTC [7] LOG:  consistent recovery state reached at 0/3E000138
    2021-09-07 07:59:41.740 UTC [1] LOG:  database system is ready to accept read only connections
    2021-09-07 07:59:42.335 UTC [7] LOG:  redo done at 0/3E000138
    2021-09-07 07:59:42.670 UTC [7] LOG:  restored log file "00000001000000000000003E" from archive
    2021-09-07 07:59:43.214 UTC [7] LOG:  selected new timeline ID: 2
    2021-09-07 07:59:43.288 UTC [7] LOG:  archive recovery complete
    2021-09-07 07:59:43.905 UTC [1] LOG:  database system is ready to accept connections
    ^C2021-09-07 07:59:49.911 UTC [1] LOG:  received fast shutdown request
    2021-09-07 07:59:49.917 UTC [1] LOG:  aborting any active transactions
    2021-09-07 07:59:49.921 UTC [1] LOG:  background worker "logical replication launcher" (PID 232) exited with exit code 1
    2021-09-07 07:59:49.921 UTC [76] LOG:  shutting down
    2021-09-07 07:59:49.962 UTC [1] LOG:  database system is shut down

