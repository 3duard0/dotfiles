#!/bin/bash

cd ansible
ansible-playbook bootstrap.yml -i inventory --ask-become-pass
