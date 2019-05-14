#!/usr/bin/env bash

cd ../ && git pull && cd provision

ansible-playbook -i inventory/ci playbook/provision_ci.yml -vvv