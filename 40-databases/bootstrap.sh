#!/bin/bash


dnf install ansible -y
git clone https://github.com/mahesh050917/ansible-roboshop-roles-tf.git
cd ansible-roboshop-roles-tf
ansible-playbook -i inventory.ini components.yaml -e component=$1