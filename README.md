# Django Starter with Ecommerce Basic

This is a django rest api with jwt based authentication. What are included:

- Custom `User` model with email and password based auth (no username)
- `Django Rest Framework` and `Simple JWT` for JWT based auth
- Automatic user `signup`, `login`, `reset password` with `Djoser`
- `SMTP` based email setup in `settings`
- Distinct `Profile` models based on user role, e.g. `MANAGER`, `CUSTOMER` etc.
- Basic `Product` model
- Basic `Order` model with `signals` to auto update cart items based on changes

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
