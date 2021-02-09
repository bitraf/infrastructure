if [[ ! -x vault-password ]]
then
  echo "./vault-password does not exist, please read README.md"
else
  export ANSIBLE_VAULT_PASS="$($(pwd)/vault-password)"

  if [[ -r settings.vault ]]
  then
    echo "Sourcing ./settings.vault"
    $(ansible-vault view settings.vault)
  fi
fi

echo "Adding bin/ to PATH"
PATH="$(pwd)/bin:$PATH"
