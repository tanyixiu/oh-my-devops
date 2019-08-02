#!/usr/bin/env bash

current_script_dir="$( cd "$(dirname "$0")" ; pwd -P )"

source ${current_script_dir}/connection.sh

function get_ci_server_ip {
  echo "Getting AWS instance CI-Server IP ......"
  get_aws_public_ip_by_name CI-Server
}

function get_ci_server_status {
  echo "Getting AWS instance CI-Server status ......"
  get_aws_instance_status_by_name CI-Server
}

function start_aws_ci_server {
  echo "Starting AWS instance CI-Server ......"
  start_aws_instance_by_name CI-Server
}

function stop_aws_ci_server {
  echo "Stopping AWS instance CI-Server ......"
  stop_aws_instance_by_name CI-Server
}

function ssh_aws_ci_server {
  echo "Login to AWS CI-Server ......"
  ssh_into_aws_instance CI-Server
}

param=$1

case "${param}" in
  "status")
    get_ci_server_status
    ;;
  "start")
    start_aws_ci_server
    ;;
  "stop")
    stop_aws_ci_server
    ;;
  "ssh")
    ssh_aws_ci_server
    ;;
  "ip")
    get_ci_server_ip
    ;;
esac

alias aws.ci.status=get_ci_server_status
alias aws.ci.start=start_aws_ci_server
alias aws.ci.stop=stop_aws_ci_server
alias aws.ci.ssh=ssh_aws_ci_server
alias aws.ci.ip=get_ci_server_ip