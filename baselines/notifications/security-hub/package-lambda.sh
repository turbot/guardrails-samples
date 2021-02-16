#!/usr/bin/env bash

python3 -m venv .packaging
source .packaging/bin/activate
pip3 install pymemcache
deactivate

cd .packaging/lib/python3.8/site-packages
zip -r ../../../../my-deployment-package.zip .
cd -
zip -g my-deployment-package.zip lambda_function.py
rm -rf .packaging