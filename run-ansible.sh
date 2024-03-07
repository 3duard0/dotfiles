#!/bin/bash

ansible-playbook bootstrap.yml -i inventory --ask-become-pass
