#!/usr/bin/env bash

python3 -m venv .packaging
source .packaging/bin/activate
pip3 install pymemcache
deactivate

rm deployment_package.zip
cd .packaging/lib/python3.8/site-packages
zip -r ../../../../deployment_package.zip .
cd -
zip -g deployment_package.zip lambda_function.py logic/*
rm -rf .packaging