help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

test: ## Run tests
	flutter test

build_android: ## Build android
	flutter build apk --release

auto_format: ## Autoformat the code base following lint rules
	dart format lib/ test/

