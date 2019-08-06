#!/usr/bin/env bash

CURRENT_SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
source ${CURRENT_SCRIPT_DIR}/connection.sh

function create_aws_instance {
  local instance_name=$1
  echo "Creating AWS instance ${instance_name} ......"
  create_aws_instance_by_name ${instance_name}
}

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

function get_aws_instance_info {
  local instance_name=$1
  echo "Getting AWS instance ${instance_name} info ......"
  get_aws_instance_infos_by_name ${instance_name}
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
    "create")
      create_aws_instance ${instance_name}
      ;;
    "status")
      get_aws_instance_status ${instance_name}
      ;;
    "start")
      start_aws_instance ${instance_name}
      ;;
    "stop")
      stop_aws_instance ${instance_name}
      ;;
    "info")
      get_aws_instance_info ${instance_name}
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

alias aws.ci.create="my_aws create ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.status="my_aws status ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.start="my_aws start ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.stop="my_aws stop ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.info="my_aws info ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.ssh="my_aws ssh ${AWS_CI_INSTANCE_NAME}"
alias aws.ci.ip="my_aws ip ${AWS_CI_INSTANCE_NAME}"


AWS_SPRING_SERVER="SpringServer"

alias aws.spring.create="my_aws create ${AWS_SPRING_SERVER}"
alias aws.spring.status="my_aws status ${AWS_SPRING_SERVER}"
alias aws.spring.start="my_aws start ${AWS_SPRING_SERVER}"
alias aws.spring.stop="my_aws stop ${AWS_SPRING_SERVER}"
alias aws.spring.info="my_aws info ${AWS_SPRING_SERVER}"
alias aws.spring.ssh="my_aws ssh ${AWS_SPRING_SERVER}"
alias aws.spring.ip="my_aws ip ${AWS_SPRING_SERVER}"


function start_all_aws_instances {
  aws.ci.start
  aws.spring.start
}

alias aws.stop.all="stop_all_aws_instances"
alias aws.start.all="start_all_aws_instances"
