#!/bin/bash

sudo snap install docker
sudo docker-compose build 
sudo docker-compose up -d