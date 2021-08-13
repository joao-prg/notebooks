# Import .env file environment variables
include .env

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = notebooks
PYTHON_VERSION := $(shell python -V )
SRC_DIR = src
TESTS_DIR = tests

#################################################################################
# COMMANDS                                                                      #
#################################################################################

project-info:
	@echo "PROJECT_NAME: $(PROJECT_NAME) \nPYTHON_VERSION: $(PYTHON_VERSION)"

## Set up python interpreter environment
create_environment:
	python3 -m venv venv --clear

## Test python environment is setup correctly
test_environment:
	$(PYTHON_INTERPRETER) test_environment.py

## Install Python Dependencies
install_dependencies: test_environment
	(source venv/bin/activate;)
	$(PYTHON_INTERPRETER) -m pip install -U pip setuptools wheel
	$(PYTHON_INTERPRETER) -m pip install -r requirements.txt
	$(PYTHON_INTERPRETER) -m pip freeze

## Running style analysis
checkstyle:
	flake8 $(SRC_DIR)
	flake8 $(TESTS_DIR)

## Run static type analysis
typecheck:
	mypy $(SRC_DIR)
	mypy $(TESTS_DIR)

## Run documentation analysis
doccheck:
	pydocstyle $(SRC_DIR)

## Run code formatting analysis
code-formatting-analysis:
	yapf --recursive --diff *
	isort --check-only *

## Run static analysis
static-analysis: project-info checkstyle typecheck doccheck code-formatting-analysis

## Delete all compiled Python files
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

## Run unit tests
unit-tests: project-info
	python -m unittest
