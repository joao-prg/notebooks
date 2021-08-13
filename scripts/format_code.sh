#!/usr/bin/env bash

source /Users/joaogoncalves/Documents/code/notebooks/venv/bin/activate

run_add_trailing_comma()
  {
  # Verify if it is a folder
  if [ -d "${1}" ]
  then
    # It is a folder
    # iterate_over_folders ${1}
    find "${1}" -name "*.py" -exec add-trailing-comma --py36-plus {} \;
  else
    # it is a file
    add-trailing-comma --py36-plus "${1}"
  fi
}

run_yapf()
{
  yapf --recursive --parallel --in-place --verbose "${1}"
}

run_yapf "${1}"
run_add_trailing_comma "${1}"
run_yapf "${1}"
isort "${1}"

deactivate
