#!/bin/sh

PARAM_ROOT=/novera/web/prd
QUERY="Parameter.Value"

# AWS Settings
export AWS_DEFAULT_REGION=ap-northeast-1
export AWS_DEFAULT_OUTPUT=text


# Database
export DB_NAME=$(aws ssm get-parameter --name ${PARAM_ROOT}/db-name --query ${QUERY})
export DB_USER=$(aws ssm get-parameter --name ${PARAM_ROOT}/db-user --query ${QUERY})
export DB_PASSWORD=$(aws ssm get-parameter --name ${PARAM_ROOT}/db-password --query ${QUERY} --with-decryption)
export DB_HOST=$(aws ssm get-parameter --name ${PARAM_ROOT}/db-host --query ${QUERY})
export DB_PORT=$(aws ssm get-parameter --name ${PARAM_ROOT}/db-port --query ${QUERY})
export DB_ENGINE=$(aws ssm get-parameter --name ${PARAM_ROOT}/db-engine --query ${QUERY})

# Redis
export REDIS_HOST=$(aws ssm get-parameter --name ${PARAM_ROOT}/redis-host --query ${QUERY})
export REDIS_PORT=$(aws ssm get-parameter --name ${PARAM_ROOT}/redis-port --query ${QUERY})

# SendGrid
export SENDGRID_API_KEY=$(aws ssm get-parameter --name ${PARAM_ROOT}/sendgrid-api-key --query ${QUERY} --with-decryption)

# URL
export ERROR_PAGE=$(aws ssm get-parameter --name ${PARAM_ROOT}/error-page --query ${QUERY})
export ORDER_COMPLETE_PAGE=$(aws ssm get-parameter --name ${PARAM_ROOT}/order-complete-page --query ${QUERY})
export MEMBER_COMPLETE_PAGE=$(aws ssm get-parameter --name ${PARAM_ROOT}/member-complete-page --query ${QUERY})
export BASE_URL=$(aws ssm get-parameter --name ${PARAM_ROOT}/base-url --query ${QUERY})
export EPSILON_URL=$(aws ssm get-parameter --name ${PARAM_ROOT}/epsilon-url --query ${QUERY})

exec uwsgi --ini /etc/uwsgi/vassals/api.ini

