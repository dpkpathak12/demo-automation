#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo service ngnix start
echo "Welcome to Nginx-Server - Virtual Server is at ${self.public_dns}" | sudo tee /var/www/html/index.html
sudo apt install cron -y
(crontab -l 2>/dev/null; echo " 0 1 * * * init 0 ") | crontab -
