#!/bin/bash

# Default values
PYTHON="python3"
PIP="pip3"
DELETE_ORIGINAL=true

# Function to display usage
usage() {
    echo "Usage: $0 [-p python_executable] [-i pip_executable] [--keep-original] <your preferred name>"
    exit 1
}

# Parse optional arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -p) PYTHON="$2"; shift ;;
        -i) PIP="$2"; shift ;;
        --keep-original) DELETE_ORIGINAL=false ;;
        -h|--help) usage ;;
        --) shift; break ;;
        -*|--*=) echo "Unknown option $1" >&2; usage ;;
        *) break ;;
    esac
    shift
done

# Check if the user provided the required argument
if [ "$#" -ne 1 ]; then
    usage
fi

# Check if the user provided the required argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [-p python_executable] [-i pip_executable] <your preferred name>"
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
$PYTHON -m venv .venv

# Activate
source ".venv/bin/activate"

# Install the requirements
if [ $? -eq 0 ]; then
    echo "Virtual environment activated successfully"
    $PIP install -r requirements.txt
else
    echo "Failed to activate virtual environment"
    exit 1
fi

# Copy .env.example to .env
if [ -f ".env.example" ]; then
    cp .env.example .env
    echo ".env file created successfully. Feel free to make changes."

    # Generate a 60-character long secret
    SECRET_KEY=$($PYTHON -c 'import secrets; print(secrets.token_urlsafe(60))')

    # Update the SECRET_KEY in the .env file
    sed -i '' "s/^SECRET_KEY=.*/SECRET_KEY=${SECRET_KEY}/" .env

    echo "SECRET_KEY updated successfully"
else
    echo ".env.example file not found"
    exit 1
fi

# Delete .git and the script itself
if $DELETE_ORIGINAL; then
    echo "\nDeleting .git directory..."
    rm -rf .git
    # Self-destruction
    echo "\nScript ran successfully. Deleting the script from this directory. If you need, pls try pulling the repo again."
    rm -- "$0"
fi
