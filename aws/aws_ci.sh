#!/usr/bin/env bash

local current_script_dir="$( cd "$(dirname "$0")" ; pwd -P )"
source ${current_script_dir}/connection.sh

function get_aws_instance_ip {
  local instance_name=$1
  echo "Getting AWS instance ${instance_name} IP ......"
  get_aws_public_ip_by_name ${instance_name}
}

function get_aws_instance_status {
  local instance_name=$1
  echo "Getting AWS instance ${instance_name} status ......"
  get_aws_instance_status_by_name ${instance_name}
}

function start_aws_instance {
  local instance_name=$1
  echo "Starting AWS instance ${instance_name} ......"
  start_aws_instance_by_name ${instance_name}
}

function stop_aws_instance {
  local instance_name=$1
  echo "Stopping AWS instance ${instance_name} ......"
  stop_aws_instance_by_name ${instance_name}
}

function ssh_aws_instance {
  local instance_name=$1
  echo "Login to AWS ${instance_name} ......"
  ssh_into_aws_instance ${instance_name}
}

function my_aws {
  local param=$1
  local instance_name=$2

  case "${param}" in
    "status")
      get_aws_instance_status ${instance_name}
      ;;
    "start")
      start_aws_instance ${instance_name}
      ;;
    "stop")
      stop_aws_instance ${instance_name}
      ;;
    "ssh")
      ssh_aws_instance ${instance_name}
      ;;
    "ip")
      get_aws_instance_ip ${instance_name}
      ;;
  esac
}

AWS_CI_INSTANCE_NAME="CI-Server"

alias aws.ci.status="my_aws status ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.start="my_aws start ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.stop="my_aws stop ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.ssh="my_aws ssh ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.ip="my_aws ip ${AWS_CI_INSTANCE_NAME}"