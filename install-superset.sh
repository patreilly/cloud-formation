#!/bin/bash
yum update -y
yum install python36-setuptools -y
yum install gcc gcc-c++ libffi-devel python36-devel python36-pip python36-wheel openssl-devel libsasl2-devel openldap-devel -y
python3 -m venv superset
. superset/bin/activate
wget ftp://ftp.freetds.org/pub/freetds/stable/freetds-patched.tar.gz
tar xvzf freetds-patched.tar.gz
freetds-1.00.111/configure
pip3 install Cython
pip3 install pandas==0.23.4
pip3 install pymssql
pip3 install superset

#create admin user
fabmanager create-admin --app superset --username admin --password StU05CbN5dbQINRM --firstname pat --lastname reilly --email pat@1strategy.com

# Initialize the database
superset db upgrade

# Load some data to play with
#superset load_examples

# Create default roles and permissions
superset init

# To start a development web server on port 8088, use -p to bind to another port
superset runserver -d