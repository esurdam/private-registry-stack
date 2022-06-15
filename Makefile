include .env
export $(shell sed 's/=.*//' .env)

check_defined = \
				$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
				  $(if $(value $1),, \
				  $(error Undefined $1$(if $2, ($2))$(if $(value @), \
				  required by target `$@')))

.PHONY: ssl
ssl: ## Run a Dockerfile from the command at the top of the file (ex. DIR=telnet).
	@echo "\033[96m• Running ssl for $$REGISTRY_DOMAIN\033[00m"
	@$(CURDIR)/create-ssl.sh "$(REGISTRY_DOMAIN)"

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'	