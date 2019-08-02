#!/usr/bin/env bash

source ./connection.sh

function upload_file_to_aws_instance {
  instance_name=$1
  file_name=$2

  ip_address=$(get_aws_public_ip_by_name ${instance_name})

  key_name=$(get_aws_instance_key_by_name ${instance_name})

  scp -i ~/Scripts/AWS/Keys/${key_name}.pem -o StrictHostKeyChecking=no ~/Scripts/AWS/Packages/${file_name} ec2-user@${ip_address}:~/
}



upload_file_to_aws_instance CI-Server jdk-8u221-linux-x64.tar.gz