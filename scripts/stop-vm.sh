#! /bin/bash

Project=""
zone="asia-south1-c"
gcloud config set project $Project 

gcloud config set compute/zone $zone

# Get the list of all running instances and store it in a variable
all_running_instances=$(gcloud compute instances list --filter="status=RUNNING" --format="value(name)")

# Specify the instance name to exclude
instance_to_exclude="gcp-vm-mgr"  # Replace with the actual instance name

# Filter out the instance to exclude from the list
running_instances=""
for instance_name in $all_running_instances; do
    if [ "$instance_name" != "$instance_to_exclude" ]; then
        running_instances="$running_instances $instance_name"
    fi
done

# Iterate through each instance in the list and stop it
for instance_name in $running_instances; do
    gcloud compute instances stop $instance_name
done

# log update in a temporary file on server, this file needs to be rotated manually

echo "stopper success @" $(date) >> /tmp/vm-stopper.log