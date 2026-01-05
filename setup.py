#IN TERMINAL:
# create evnv from terminal: python -m venv venv
#switch evnv on: venv\Scripts\activate
#copy paste in terminal: pip install -e .

#once done: dagster dev  
from setuptools import setup, find_packages

setup(
    name='dagster_projects',
    version='1.10.0', #  Check Version for latest
    packages=find_packages(),
    install_requires=[
        'dagster',
        'clickhouse-connect',
        'python-dotenv',
        'sqlalchemy',
        'dagster-postgres',
        'pandas',
        'pyodbc',
        'dagster-webserver',
        'sqlalchemy',
        'numpy',
        'paramiko',
        'clickhouse-sqlalchemy',
        'requests', 
        'aiohttp',
        'pywebpush'
    ]
)