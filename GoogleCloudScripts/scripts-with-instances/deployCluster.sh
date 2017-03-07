#!/bin/bash

if [ $# -le 1 ]; then
	echo "Usage: ./deployCluster.sh -n <number of instances> -c <1 for create disk/any number otherwise> -p <node name prefix, default node> -t <machin type> -s <startup script>"
	exit
fi

ATTACH_DISK=0
NUM_INSTANCE=0
NAME_PREFIX="node"
MACHINE_TYPE="n1-standard-4"
STARTUP_SCRIPT="startup.sh"
while [[ $# > 1 ]]
do
key="$1"
shift

case $key in
    -n|--num_instance)
    NUM_INSTANCE="$1"
    shift
    ;;
    -c|--create_disk)
    ATTACH_DISK="$1"
    shift
    ;;
    -p|--name_prefix)
    NAME_PREFIX="$1"
    shift
    ;;
    -t|--machine_type)
    MACHINE_TYPE="$1"
    shift
    ;;
    -s|--startup_script)
    STARTUP_SCRIPT="$1"
    shift
    ;;
    *)
            # unknown option
    ;;
esac
done

#Creating a persistent disk

if [ $ATTACH_DISK -eq 1 ]; then
	echo "gcloud compute disks create datadisk --zone us-central1-a --size 1TB"
	gcloud compute disks create datadisk --zone us-central1-a --size 1TB --project ferrous-osprey-732
fi

node_array=""
for (( i=1; i<=$NUM_INSTANCE; i++ ))
do
    node_array="$node_array $NAME_PREFIX$i"
done

echo "gcloud compute instances create $node_array --zone us-central1-a --image debian-7 --machine-type $MACHINE_TYPE --disk name=datadisk mode=ro --project ferrous-osprey-732 --metadata-from-file startup-script=$STARTUP_SCRIPT"
gcloud compute instances create $node_array --zone us-central1-a --image debian-7 --machine-type $MACHINE_TYPE --project ferrous-osprey-732 --metadata-from-file startup-script=$STARTUP_SCRIPT

#gcloud compute instances create $node_array --zone us-central1-a --image debian-7 --machine-type $MACHINE_TYPE --disk name=datadisk mode=ro --project ferrous-osprey-732 --metadata-from-file startup-script=$STARTUP_SCRIPT

#echo "gcloud compute instances attach-disk $node_array --disk datadisk --zone us-central1-a --mode ro"
#gcloud compute instances attach-disk $node_array --disk datadisk --zone us-central1-a --mode ro
