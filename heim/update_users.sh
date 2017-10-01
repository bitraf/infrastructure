#!/bin/sh -eu

ansible-vault decrypt roles/users/vars/main.json \
    --output roles/users/vars/main.json.old.not_encrypted

<users.sql ssh bomba.bitraf.no psql p2k12 2>/dev/null |
    jq . >roles/users/vars/main.json.new.not_encrypted

diff -u roles/users/vars/main.json.old.not_encrypted \
    roles/users/vars/main.json.new.not_encrypted || true

ansible-vault encrypt roles/users/vars/main.json.new.not_encrypted \
    --output roles/users/vars/main.json
