from setuptools import setup, find_packages

with open('README.md') as f:
    readme = f.read()

setup(
    name='trimbot',
    version='0.3',
    description='Automated Turbot Account Cleanup',
    long_description=readme,
    author='Turbot Inc',
    py_modules=['main'],
    install_requires=[
        'click',
        'jsonschema',
        'PyYAML',
        'boto3',
        "requests",
        "urllib3"
    ],
    packages=['trimbot_modules'],
    entry_points='''
        [console_scripts]
        trimbot=main:cli
    ''',
)
