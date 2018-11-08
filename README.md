bitraf infrastructure
=====================

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

See also
--------

Infrastructure on the Bitraf wiki:
- [Nettverk](https://bitraf.no/wiki/Nettverk)
- [Bite](https://bitraf.no/wiki/Bite)
- [Heim](https://bitraf.no/wiki/Heim)
