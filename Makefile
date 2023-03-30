.DEFAULT_GOAL := default

default:
	@echo "Welcome to the make menu. Enter command or list for the list of commands."

list:
	@echo "\nThe available commands are:\n"
	@echo "manifest"
	@echo "fetch-app"
	@echo "app"
	@echo "clean"
	@echo ""

manifest:
	cd Tuist
	tuist edit

app:
	$(MAKE) generate
	sh scripts/generate_api_token.sh
	tuist generate

clean:
	tuist clean

fetch-app:
	$(MAKE) generate
	tuist fetch
	tuist generate

generate-token:
	sh scripts/generate_api_token.sh

generate:
	$(MAKE) generate-token
