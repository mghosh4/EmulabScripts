#!/bin/bash

NUM_INSTANCE=3
NAME_PREFIX="node"
MACHINE_TYPE="n1-standard-16"
PROJECT_NAME="redwaters"
while [[ $# -ge 1 ]]
do
key="$1"
shift

case $key in
    -n|--num_instance)
    NUM_INSTANCE="$1"
    shift
    ;;
    -p|--name_prefix)
    NAME_PREFIX="$1"
    shift
    ;;
    -t|--instance_type)
    MACHINE_TYPE="$1"
    shift
    ;;
    -p|--project_name)
    PROJECT_NAME="$1"
    shift
    ;;
    -h|--help)
    echo "Usage: ./deployCluster.sh -p <project name, default redwaters> -n <number of instances, default 3> -b <base name, default node> -t <instance-template, default n1-standard-16>"
    exit
    shift
    ;;
    *)
            # unknown option
    ;;
esac
done

CREATE_CMD="gcloud compute instance-groups managed create $PROJECT_NAME -q --base-instance-name $NAME_PREFIX --size $NUM_INSTANCE --template $MACHINE_TYPE --zone us-central1-a"
echo "$CREATE_CMD"
$CREATE_CMD

WAIT_STABLE="gcloud compute instance-groups managed wait-until-stable $PROJECT_NAME --zone us-central1-a"
echo "$WAIT_STABLE"
$WAIT_STABLE
