#!/usr/bin/env bash

function get_aws_instance_info_by_name {
  instance_name=$1

  filed_name=$2

  aws_instance_info=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance_name}" --query "Reservations[0].Instances[0].${filed_name}" --output text | awk -F\" '{print $1}')

  echo ${aws_instance_info}
}

function get_aws_instance_id_by_name {
  instance_name=$1

  instance_id=$(get_aws_instance_info_by_name ${instance_name} "InstanceId")

  echo ${instance_id}
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

function get_aws_instance_status_by_name {
  instance_name=$1

  state=$(get_aws_instance_info_by_name ${instance_name} "State.Name")

  echo ${state}
}

function ssh_into_aws_instance {
  instance_name=$1

  ip_address=$(get_aws_public_ip_by_name ${instance_name})

  key_name=$(get_aws_instance_key_by_name ${instance_name})

  ssh -i ~/Scripts/AWS/Keys/${key_name}.pem -o StrictHostKeyChecking=no ec2-user@${ip_address}
}

function start_aws_instance_by_name {
  instance_name=$1
  instance_id=$(get_aws_instance_id_by_name ${instance_name})
  aws ec2 start-instances --instance-ids ${instance_id}
}

function stop_aws_instance_by_name {
  instance_name=$1
  instance_id=$(get_aws_instance_id_by_name ${instance_name})
  aws ec2 stop-instances --instance-ids ${instance_id}
}


