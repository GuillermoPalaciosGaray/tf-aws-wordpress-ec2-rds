#!/bin/bash
sudo su
yum -y update
yum install -y httpd
yum install -y docker
systemctl enable docker
service docker start
usermod -a -G docker ec2-user
systemctl enable docker.service
sudo docker pull wordpress
sudo docker run -d -p 80:80 -p 443:443 wordpress