#!/usr/bin/env bash

function get_aws_instance_info_by_name {
  instance_name=$1

  filed_name=$2

  aws_instance_info=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance_name}" | grep "${filed_name}" | awk -F\"  '{print $4}')

  echo ${aws_instance_info}
}

function get_aws_public_ip_by_name {
  instance_name=$1

  ip_address=$(get_aws_instance_info_by_name ${instance_name} "PublicIpAddress")

  echo ${ip_address}
}

function get_aws_instance_key_by_name {
  instance_name=$1

  key_name=$(get_aws_instance_info_by_name ${instance_name} "KeyName")

  echo ${key_name}

}

function ssh_into_aws_instance {
  instance_name=$1

  ip_address=$(get_aws_public_ip_by_name ${instance_name})

  key_name=$(get_aws_instance_key_by_name ${instance_name})

  ssh -i ~/Scripts/AWS/Keys/${key_name}.pem -o StrictHostKeyChecking=no ec2-user@${ip_address}
}

function ssh_aws_ci_server {
  echo "Login to AWS CI-Server ......"
  ssh_into_aws_instance CI-Server
}

ssh_aws_ci_server