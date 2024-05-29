# Django Starter with Ecommerce Basic

This is a django rest api with jwt based authentication. What are included:

- Custom `User` model with email and password based auth (no username)
- `Django Rest Framework` and `Simple JWT` for JWT based auth
- Automatic user `signup`, `login`, `reset password` with `Djoser`
- `SMTP` based email setup in `settings`
- Distinct `Profile` models based on user role, e.g. `MANAGER`, `CUSTOMER` etc.
- Basic `Product` model
- Basic `Order` model with `signals` to auto update cart items based on changes

Disclaimer: This is developed and tested in MacOS, should work out-of-the-box with Linux as well, and might need adjustments for windows in the shell script.

## Already familiar with the commands? Just run the following. Otherwise jumpt to [`How to start`](#how-to-start-if-you-are-for-the-first-time-with-this-repo) section

Taking into consideration that you're already in a blank project directory of your preferred name.
!!Important!! Change the main app name `<your preferred name>` here before running.

- Clone the repo

```bash
git clone https://github.com/7shovon7/simplest-django-drf-starter-template .
```

- Run the init.sh script with your preferred `<your preferred app name>`

```bash
./init.sh <your preferred app name>
```

If you face permission error, allow the script execution permission

```bash
chmod +x init.sh
```

- Activate the virtual environment

```bash
source .venv/bin/activate
```

- Migrate and test run with `sqlite3` db

```bash
python3 manage.py makemigrations
# Migrate db
python3 manage.py migrate
# Run
python3 manage.py runserver
```

You're done!!

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

- Create fresh migration files and migrate with `sqlite3` db

```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

- Run and test the server

```bash
python3 manage.py runserver
```
