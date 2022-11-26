if [[ ! -x vault-password ]]
then
  echo "./vault-password does not exist, please read README.md"
else
  export ANSIBLE_VAULT_PASS="$($(pwd)/vault-password)"

  . <(ansible-vault view terraform.vault)

  if [[ -r settings.vault ]]
  then
    echo "Sourcing ./settings.vault"
    . <(ansible-vault view settings.vault)
  fi
fi

export ANSIBLE_CONFIG=$(pwd)/ansible.cfg

echo "Adding bin/ to PATH"
PATH="$(pwd)/bin:$PATH"
echo "Adding env/bin/ to PATH"
PATH="$(pwd)/env/bin:$PATH"
