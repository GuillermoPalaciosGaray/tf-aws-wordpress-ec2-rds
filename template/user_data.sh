#!/bin/bash
sudo su
yum -y update
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello Word from EC2</h1>" > /var/www/html/index.html