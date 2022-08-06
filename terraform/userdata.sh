#!/bin/bash

pwd > /userdata_output
whoami >> /userdata_output
cd /home/ubuntu/repo && bash run_server.sh