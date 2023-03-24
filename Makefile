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
	tuist generate

clean:
	tuist clean

fetch-app:
	tuist fetch
	tuist generate