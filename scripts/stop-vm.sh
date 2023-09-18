#! /bin/bash

#gcloud info 

#gcloud projects list

# arguments

#Project=$1   #project id that you'll be working on 
Project=""

#vminsta=$2  #vm instances name that you are starting within that project id 
vminsta=testvm
#zone=$3    # zone of vm instance that is running in, this format will be in i.e  --zone=us-central1-a 
zone="--zone=asia-south1-c"
gcloud config set project $Project 

#gcloud compute instances list 


#gcloud compute instances start $vminsta $zone

#gcloud compute ssh $vminsta $zone



# An error exit function

error_exit()
{
    echo "$1" 1>&2
    exit 1
}

# Using error_exit

if gcloud compute instances list --filter="status=running"; then

  echo "Instance name: $instances"

else
    error_exit "Cannot start!  Aborting."
fi 
  if echo "logout"; then 
  gcloud compute instances stop $vminsta $zone 

  echo "gcloud compute instances stopping"  

else
  error_exit "cannot stop" 
fi