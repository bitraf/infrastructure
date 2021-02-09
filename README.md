bitraf infrastructure
=====================

`.settings.sh`
--------------

To get our tools put in your $PATH and secrets loaded (see
`settings.vault`), always source .settings.sh when opening a new
terminal:

    $ . .settings.sh
    Sourcing ./settings.vault
    Adding bin/ to PATH

Python requirements
-------------------

Install dependencies:

    pip3 install --user -r requirements.txt

ansible-vault settings
----------------------

First, run `git submodule update --init`. Then run
`bash misc/ansible-vault-tools/gpg-vault-password-file.sh vault-password`
(but make sure you have a valid gpg key locally first). When asked for
a password, give the password for the vault. This will store the vault
password in a GPG encrypted file locally. As GPG uses your system's
keychain, you won't be asked for passwords all the time.

use ansible-vault to handle secrets:

    apt install ansible

create a secret file

    ansible-vault create secrets.txt

edit a secret file

    ansible-vault edit secrets.txt

For sane git integration put this in `$HOME/.gitconfig`:

    # gitconfig
    [diff "ansible-vault"]
      textconv = ansible-vault view
      # Do not cache the vault contents
      cachetextconv = false

See also: https://github.com/building5/ansible-vault-tools

**Git config**: Run this to show the plain text diff on vault files:

   git config diff.ansible-vault.textconv ansible-vault view

`./settings.vault`
------------------

When using Terraform, you need to have a ansible-vault file called
settings.vault. It can be created with

    ansible-vault create settings.vault

It's content should be:

    export LINODE_TOKEN=
    export AWS_ACCESS_KEY_ID=
    export AWS_SECRET_ACCESS_KEY=

The values you will get from your Bitraf Linode account if you have
access. The `LINODE_TOKEN` is a "personal access token v4" and the AWS
keys are created under 
[Object Storage](https://cloud.linode.com/object-storage/buckets).
Make sure that the token has access to the `bitraf-terraform` bucket.

Name the tokens `$username-$machine`.

See also
--------

Infrastructure on the Bitraf wiki:
- [Nettverk](https://bitraf.no/wiki/Nettverk)
- [Bite](https://bitraf.no/wiki/Bite)
- [Heim](https://bitraf.no/wiki/Heim)
