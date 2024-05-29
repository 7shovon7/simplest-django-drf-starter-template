# Django Starter with Ecommerce Basic

This is a django rest api with jwt based authentication. What are included:

- Custom `User` model with email and password based auth (no username)
- `Django Rest Framework` and `Simple JWT` for JWT based auth
- Automatic user `signup`, `login`, `reset password` with `Djoser`
- `SMTP` based email setup in `settings`
- Distinct `Profile` models based on user role, e.g. `MANAGER`, `CUSTOMER` etc.
- Basic `Product` model
- Basic `Order` model with `signals` to auto update cart items based on changes

## Already familiar with the commands? Just run the following (Taking into consideration that you're already in a blank project directory of your preferred name). Otherwise jumpt to `How to start` section

```bash
# Clone
git clone https://github.com/7shovon7/simplest-django-drf-starter-template .
# Rename the main app
find . -type d -name 'house_of_spice' | while read dir; do mv "$dir" "$(dirname "$dir")/<your preferred name>"; done
# Replace the strings in different files
find . -type f -exec sed -i '' 's/house_of_spice/<your preferred name>/g' {} +
# Create and activate virtual environment
python3 -m venv .venv
source .venv/bin/activate
# Install the requirements
pip3 install -r requirements.txt
# Delete existing migrations files for a fresh start
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
```

Migrate and test run

```bash
python3 manage.py makemigrations
# Migrate db
python3 manage.py migrate
# Run
python3 manage.py runserver
```

you're done!!

## How to start (If you are for the first time with this repo)

- Create a project directory

```bash
mkdir project-name
cd project-name
```

- Clone the repo in existing directory

```bash
git clone https://github.com/7shovon7/simplest-django-drf-starter-template .
```

- Search and replace the project app `house_of_spice` with your preferred name `<your preferred name>`

```bash
# Rename the main app
find . -type d -name 'house_of_spice' | while read dir; do mv "$dir" "$(dirname "$dir")/<your preferred name>"; done
# Replace the strings in different files
find . -type f -exec sed -i '' 's/house_of_spice/<your preferred name>/g' {} +
```

- Create and activate virtual environment

```bash
python3 -m venv .venv
source .venv/bin/activate
```

- Install the requirements

```bash
pip3 install -r requirements.txt
```

- Delete existing migration files

```bash
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete
```

- Create fresh migration files and migrate

```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

- Run and test the server

```bash
python3 manage.py runserver
```
