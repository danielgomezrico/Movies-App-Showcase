help:
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-30s\033[0m %s\n", $$1, $$2}'

test: ## Run tests
	make prepare
	flutter test

run:
	make prepare
	flutter run

prepare: ## Auto generate files
	dart run build_runner build

prepare_watch: ## Auto generate files
	dart run build_runner watch

build_android: ## Build android
	flutter build apk --release

auto_format: ## Autoformat the code base following lint rules
	dart format lib/ test/

check_linters: ## Run all linters
	flutter analyze
	flutter format --set-exit-if-changed lib/ test/

app_uninstall: ## Uninstall app from android device for tests
	adb uninstall com.movie.movie_flutter