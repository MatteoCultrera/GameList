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
	sh scripts/generate_api_token.sh
	tuist generate

clean:
	tuist clean

fetch-app:
	sh scripts/generate_api_token.sh
	tuist fetch
	tuist generate
