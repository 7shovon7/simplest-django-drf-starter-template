# Django Starter with Ecommerce Basic

This is a django rest api with email and jwt based authentication. Have configured basic smtp server settings and product, order apps as well.

## How to start

- Create a project directory

```bash
mkdir project-name
cd project-name
```

- Clone the repo in existing directory

```bash
git clone <repo-url> .
```

- Search and replace the project app `house_of_spice` with your preferred name

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
