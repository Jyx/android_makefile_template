CONFIG=.config
CC=ant

# Don't warn if the .config file doesn't exist, but include it if it exists
-include $(CONFIG)

TARGET		?= 1
NAME		?= MyFirstApp
APP_PATH	?= ${PWD}
ACTIVITY	?= MainActivity
PACKAGE		?= com.example.myfirstapp

.PHONY: all
all: build

.PHONY:	avd
avd:
	android avd &

.PHONY: build
build:
	$(CC) debug

.PHONY: config
config:
	@echo "# This is a number you get by listing the targets" > .config
	@echo "TARGET := $(TARGET)" >> .config
	@echo "" >> .config
	@echo "# This is the name of your project" >> .config
	@echo "NAME := $(NAME)" >> .config
	@echo "" >> .config
	@echo "# This is folder where the project should be created" \
		>> .config
	@echo "APP_PATH := $(APP_PATH)" >> .config
	@echo "" >> .config
	@echo "# This is the main activity file" >> .config
	@echo "ACTIVITY := $(ACTIVITY)" >> .config
	@echo "" >> .config
	@echo "# This is the package name (com.foo.myapp)" >> .config
	@echo "PACKAGE := $(PACKAGE)" >> .config

.PHONY: list-config
list-config:
	cat .config

.PHONY: create-project
create-project:
	android create project --target $(TARGET) --name $(NAME) --path $(APP_PATH) --activity $(ACTIVITY) --package $(PACKAGE)

.PHONY: list-target
list-target:
	android list targets | less -FXR

.PHONY: install
install:
	adb install bin/$(NAME)-debug.apk

.PHONY: uninstall
uninstall:
	adb uninstall $(PACKAGE)

.PHONY: sdk
sdk:
	android sdk &

.PHONY: help
help:
	@echo "  avd              launch Android Virtual Device Manager"
	@echo "  build            build/compile the project"
	@echo "  config           create a default .config template file"
	@echo "  create-project   create a project based on current .config"
	@echo "  help             this dialog"
	@echo "  install          install apk-file on target/emulator"
	@echo "  list-config      list the currect .config template file"
	@echo "  list-target      list the android targets to choose among"
	@echo "  sdk-manager      launch Android SDK manager" 
	@echo "  uninstall        uninstall apk-file on target/emulator"
