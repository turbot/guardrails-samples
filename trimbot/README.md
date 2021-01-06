# Notes

To run this application follow the below steps.

1. [Create the virtual environment](#Create%20the%20virtual%20environment)
2. [Install Dependencies](#Install%20Dependencies)

## Create the virtual environment

This sections details how to set up a virtual environment in order for the script to run.

### Virtual environments activation

This application uses the Python version 3 module, [venv](https://docs.python.org/3/library/venv.html) to create the a virtual environment.

1. Navigate to the the root folder of the Trimbot application.
2. Use the following command to create the virtual environment. <BR>The command will create a folder called `.venv` which is a child of the root folder for the applications.

```shell
python3 -m venv .venv
```

3. Activate the environment by running the following command.

```shell
source .venv/bin/activate
```

## Install Dependencies

1. Navigate to the the root folder of the Trimbot application.
2. Install application Python library dependencies by running the following command.

```shell
pip3 install -r requirements.txt
```

## Install Application

1. Navigate to the the root folder of the Trimbot application.
2. Install the application Python by running the following command.

```shell
pip3 install .
```
