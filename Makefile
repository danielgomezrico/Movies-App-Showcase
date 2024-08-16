help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

unit-test: ## Run tests
	flutter test

prepare: ## Auto generate files
	dart run build_runner build --delete-conflicting-outputs

prepare_watch: ## Auto generate files
	dart run build_runner watch --delete-conflicting-outputs

build_android: ## Build android
	flutter build apk --release

auto_format: ## Autoformat the code base following lint rules
	dart format lib/ test/

check_linters: ## Run all linters
	flutter analyze
	flutter format --set-exit-if-changed lib/ test/

app_uninstall: ## Uninstall app from android device for tests
	adb uninstall com.movie.movie_flutter