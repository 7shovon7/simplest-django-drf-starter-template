#!/bin/bash

# Check if the user provided an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <your preferred name>"
    exit 1
fi

# Assign the provided argument to a variable
NEW_NAME=$1

# Set locale to handle illegal byte sequence
export LC_ALL=C

# Rename the main app
find . -type d -name 'house_of_spice' | while read dir; do mv "$dir" "$(dirname "$dir")/$NEW_NAME"; done

# Replace the strings in different files
find . -type f -exec sed -i '' "s/house_of_spice/$NEW_NAME/g" {} +

# Delete existing migrations files for a fresh start
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete

# Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install the requirements
pip3 install -r requirements.txt