#!/bin/bash

component=$1
environment=$2
dnf install ansible -y
pip3.9 install botocore boto3
ansible-pull -i localhost, -U https://github.com/rajalingarao/4.13.expense-ansible-roles-tf-infra-dev.git main.yaml -e component=$component -e env=$environment -e mysql_root_password=ExpenseApp1
ansible-pull -i localhost, -U https://github.com/rajalingarao/4.13.expense-ansible-roles-tf-infra-dev.git main.yaml -e component=$component -e env=$environment -e mysql_root_password=ExpenseApp1
