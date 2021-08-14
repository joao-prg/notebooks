# Import .env file environment variables
include .env

#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
PROJECT_NAME = notebooks
PYTHON_VERSION := $(shell python -V )
PYTHON_INTERPRETER = python3
SRC_DIR = src
TESTS_DIR = tests
VENV_NAME=venv

#################################################################################
# COMMANDS                                                                      #
#################################################################################

project-info:
	@echo "PROJECT_NAME: $(PROJECT_NAME) \nPYTHON_VERSION: $(PYTHON_VERSION)"

## Set up python interpreter environment
create_environment:
	python3 -m venv $(VENV_NAME) --clear

## Test python environment is setup correctly
test_environment:
	$(PYTHON_INTERPRETER) test_environment.py

## Install Python Dependencies
install_dependencies: test_environment
	(source $(VENV_NAME)/bin/activate;)
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
	rm -rf .ipynb_checkpoints

## Run unit tests
unit-tests: project-info
	python -m unittest

## Add virtual environment to Jupyter
add_venv_to_jupyter:
	python -m ipykernel install --name=$(VENV_NAME)

## Remove virtual environment from Jupyter
remove_venv_from_jupyter:
	jupyter kernelspec uninstall $(VENV_NAME)

## List Jupyter virtual environments
list_jupyter_venvs:
	jupyter kernelspec list

## Start Jupyter server
launch_jupyter:
	python -m jupyterlab

## Install JupyterLab extensions
install_jupyterlab_extensions:
	jupyter labextension install jupyterlab-tailwind-theme \
			jupyterlab-drawio \
			jupyterlab-chart-editor \
			jupyterlab-spreadsheet \
			jupyterlab-dash

## Uninstall JupyterLab extensions
uninstall_jupyterlab_extensions:
	jupyter labextension uninstall --all

## List JupyterLab extensions
list_jupyterlab_extensions:
	jupyter labextension list
