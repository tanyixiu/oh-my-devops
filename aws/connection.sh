#!/usr/bin/env bash

function get_aws_instance_infos_by_name {
  local instance_name=$1

  local aws_instance_infos=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance_name}")

  echo ${aws_instance_infos}
}

function get_aws_instance_info_by_name {
  local instance_name=$1

  local filed_name=$2

  local aws_instance_info=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=${instance_name}" --query "Reservations[0].Instances[0].${filed_name}" --output text | awk -F\" '{print $1}')

  echo ${aws_instance_info}
}

function get_aws_instance_id_by_name {
  local instance_name=$1

  local instance_id=$(get_aws_instance_info_by_name ${instance_name} "InstanceId")

  echo ${instance_id}
}

function get_aws_public_ip_by_name {
  local instance_name=$1

  local ip_address=$(get_aws_instance_info_by_name ${instance_name} "PublicIpAddress")

  echo ${ip_address}
}

function get_aws_instance_key_by_name {
  local instance_name=$1

  local key_name=$(get_aws_instance_info_by_name ${instance_name} "KeyName")

  echo ${key_name}
}

function get_aws_instance_status_by_name {
  local instance_name=$1

  local state=$(get_aws_instance_info_by_name ${instance_name} "State.Name")

  echo ${state}
}

function ssh_into_aws_instance {
  local instance_name=$1

  local ip_address=$(get_aws_public_ip_by_name ${instance_name})

  local key_name=$(get_aws_instance_key_by_name ${instance_name})

  ssh -i ~/Scripts/AWS/Keys/${key_name}.pem -o StrictHostKeyChecking=no ec2-user@${ip_address}
}

function start_aws_instance_by_name {
  local instance_name=$1
  local instance_id=$(get_aws_instance_id_by_name ${instance_name})
  aws ec2 start-instances --instance-ids ${instance_id}
}

function stop_aws_instance_by_name {
  local instance_name=$1
  local instance_id=$(get_aws_instance_id_by_name ${instance_name})
  aws ec2 stop-instances --instance-ids ${instance_id}
}

function create_aws_instance_by_name {
  local instance_name=$1
  aws ec2 run-instances \
          --image-id ami-01f7527546b557442 \
          --instance-type t2.micro \
          --key-name yixiu-aws-key \
          --security-groups default \
          --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${instance_name}}]"
}

function stop_all_aws_instances {
  aws ec2 stop-instances --instance-ids $(aws ec2 describe-instances --filters  "Name=instance-state-name,Values=pending,running" --query "Reservations[].Instances[].[InstanceId]" --output text)
}


