#!/bin/bash
component=$1
environment=$2
# Install required packages
dnf install -y ansible python3-pip
# Install Python dependencies
pip3 install botocore boto3
ansible-pull -i localhost, -U https://github.com/rajalingarao/4.13.expense-ansible-roles-tf-infra-dev.git main.yaml -e component=$component -e env=$environment