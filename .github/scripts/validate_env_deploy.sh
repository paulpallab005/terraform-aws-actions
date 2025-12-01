#!/bin/bash

ENVIRONMENT=${1}
DEPLOYMENT=${2}
REGION=${3}

# Check if all required parameters are provided
if [ -z "$ENVIRONMENT" ] || [ -z "$DEPLOYMENT" ] || [ -z "$REGION" ]; then
    echo "Error: Missing required parameters"
    echo "Usage: $0 <environment> <deployment> <region>"
    echo "Example: $0 dev blue us-east-1"
    exit 1
fi

echo "Validating deployment configuration..."
echo "Environment: $ENVIRONMENT"
echo "Deployment Type: $DEPLOYMENT"
echo "Region: $REGION"

case $ENVIRONMENT in
"dev")
    if [ "$DEPLOYMENT" != "blue" ]; then
        echo "Error: In 'dev' environment, only 'blue' deployment is allowed."
        exit 1
    else
        if [ "$REGION" == "us-east-1" ] || [ "$REGION" == "eu-west-1" ]; then
            echo "✓ Input details are valid for 'dev' environment."
        else
            echo "Error: Region '$REGION' is not valid for 'dev' environment."
            exit 1
        fi
    fi
    ;;
"test")
    if [ "$DEPLOYMENT" != "blue" ]; then
        echo "Error: In 'test' environment, only 'blue' deployment is allowed."
        exit 1
    else
        if [ "$REGION" == "us-east-1" ] || [ "$REGION" == "ap-southeast-1" ]; then
            echo "✓ Input details are valid for 'test' environment."
        else
            echo "Error: Region '$REGION' is not valid for 'test' environment."
            exit 1
        fi
    fi
    ;;
"stage")
    if [ "$REGION" == "us-east-1" ] || [ "$REGION" == "eu-west-1" ] || [ "$REGION" == "ap-southeast-1" ]; then
        echo "✓ Input details are valid for 'stage' environment."
    else
        echo "Error: Region '$REGION' is not valid for 'stage' environment."
        exit 1
    fi
    ;;
*)
    echo "Error: Invalid environment '$ENVIRONMENT'"
    echo "Valid environments: dev, sand, test, stage"
    echo "Note: ppe and prod environments do not require validation"
    exit 1
    ;;
esac

echo "Validation completed successfully!"
exit 0