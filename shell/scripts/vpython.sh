#!/bin/bash

if [[ -z "$PYTHON_VENV" ]]; then
	echo "Error: No venv selected (set the PYTHON_VENV environment variable)"
	exit 1
fi


exec "${PYTHON_VENV}/bin/python3" "$@"

