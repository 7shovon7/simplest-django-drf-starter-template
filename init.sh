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

# Create virtual environment
python3 -m venv .venv

# Activate
source ".venv/bin/activate"

# Install the requirements
if [ $? -eq 0 ]; then
    echo "Virtual environment activated successfully"
    pip3 install -r requirements.txt
else
    echo "Failed to activate virtual environment"
    exit 1
fi

# Copy .env.example to .env
if [ -f ".env.example" ]; then
    cp .env.example .env
    echo ".env file created successfully. Feel free to make changes."
else
    echo ".env.example file not found"
    exit 1
fi