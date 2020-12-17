alias terraform="ANSIBLE_VAULT_PASS=\$($(pwd)/vault-password) $(pwd)/ops/terraform/.terraform/bin/terraform"

if [[ -r linode-credentials && vault-password ]]
then
  echo "Loading ./linode-credentials"
  $(ansible-vault view linode-credentials)
fi
