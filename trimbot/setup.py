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
        'click==8.0.1',
        'jsonschema==3.2.0',
        'PyYAML==5.4.1',
        'boto3==1.18.55',
        "requests==2.26.0",
        "urllib3==1.26.17"
    ],
    packages=['trimbot_modules'],
    entry_points='''
        [console_scripts]
        trimbot=main:cli
    ''',
)
