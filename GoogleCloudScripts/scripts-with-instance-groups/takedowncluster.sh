#!/bin/bash

PROJECT_NAME="redwaters"
while [[ $# -ge 1 ]]
do
key="$1"
shift

case $key in
    -p|--name_prefix)
    NAME_PREFIX="$1"
    shift
    ;;
    -h|--help)
    echo "Usage: ./takedownCluster.sh -p <project name, default redwaters>"
    exit
    shift
    ;;
    *)
            # unknown option
    ;;
esac
done

REMOVE_CMD="gcloud compute instance-groups managed delete $PROJECT_NAME -q --zone us-central1-a"
echo "$REMOVE_CMD"
$REMOVE_CMD
