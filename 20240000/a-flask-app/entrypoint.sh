#!/bin/bash

set -e

echo "############# 20240000/a-flask-app/entrypoint.sh $(date) $(date)"

CURRENT_PWD=`pwd`
echo "############# 20240000/a-flask-app/entrypoint.sh $(date) current CURRENT_PWD: ${CURRENT_PWD}"

env

echo "############# 20240000/a-flask-app/entrypoint.sh $(date) ls -la"
ls -la

CURRENT_SCRIPT_DIR=`dirname "$0"`
echo "############# 20240000/a-flask-app/entrypoint.sh $(date) CURRENT_SCRIPT_DIR: ${CURRENT_SCRIPT_DIR}"

FLASK_PROJECT_RELATIVE_DIR="20240000/a-flask-app"

FLASK_PROJECT_ABSOLUTE_DIR="${CURRENT_PWD}/${FLASK_PROJECT_RELATIVE_DIR}"
echo "############# 20240000/a-flask-app/entrypoint.sh $(date) FLASK_PROJECT_ABSOLUTE_DIR: ${FLASK_PROJECT_ABSOLUTE_DIR}"

if [ -z "$WEBSITE_HOSTNAME" ]
then
    echo "############# 20240000/a-flask-app/entrypoint.sh $(date) \$WEBSITE_HOSTNAME is empty, we are outside the container"
else
    echo "############# 20240000/a-flask-app/entrypoint.sh $(date) \$WEBSITE_HOSTNAME is NOT empty, we are inside the container"

    (cd $FLASK_PROJECT_ABSOLUTE_DIR && pip install -r requirements.txt)

    (cd $FLASK_PROJECT_ABSOLUTE_DIR && python app.py)
fi
