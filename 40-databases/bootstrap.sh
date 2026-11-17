#!/bin/bash

component=$1
dnf install ansible -y
cd /home/ec2-user
git clone https://github.com/mahesh050917/ansible-roboshop-roles-tf.git
cd ansible-roboshop-roles-tf
git pull
ansible-playbook -i inventory.ini components.yaml -e component=$component
