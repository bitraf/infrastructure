terraform_version=0.14.2
terraform_url=https://releases.hashicorp.com/terraform/$(terraform_version)/terraform_$(terraform_version)_linux_amd64.zip
terraform_unzip=.terraform/unzip/$(terraform_version)/
terraform_zip=.terraform/zip/terraform_$(terraform_version)_linux_amd64.zip
terraform_bin=.terraform/bin/terraform

ansiblevault_version=2.0.1
ansiblevault_url=https://github.com/MeilleursAgents/terraform-provider-ansiblevault/releases/download/v$(ansiblevault_version)/terraform-provider-ansiblevault_linux_amd64_v$(ansiblevault_version)
ansiblevault_path=terraform.d/plugins/linux_amd64/terraform-provider-ansiblevault_v$(ansiblevault_version)_x4

all: $(terraform_bin) $(ansiblevault_path) setup

$(terraform_bin): $(terraform_zip)
	rm -rf $(dir $(terraform_unzip))
	mkdir -p $(terraform_unzip)
	mkdir -p $(dir $(terraform_bin))
	unzip $(terraform_zip) -d $(terraform_unzip)
	ln -sf $(PWD)/$(terraform_unzip)/terraform $(terraform_bin)
	touch $(PWD)/$(terraform_unzip)/terraform

$(terraform_zip):
	mkdir -p $(dir $@)
	curl -L -o "$@" $(terraform_url)

$(ansiblevault_path): terraform.d
	mkdir -p $(dir $@)
	curl -L -o "$@" $(ansiblevault_url)
	chmod +x $(@)

terraform.d:
	mkdir $@

MAIN=$(patsubst %/main.tf,%,$(wildcard */main.tf))
setup: $(patsubst %,%/terraform.d,$(MAIN))
.PHONY: setup

%/terraform.d: terraform.d
	ln -s ../terraform.d $@

.terraform/plugins/linux_amd64:
	mkdir -p $@
