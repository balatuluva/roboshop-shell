echo -e "\e[36m>>>>>>> Configure NodeJS repos<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>> Install NodeJS <<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>> Add application user <<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create Application Directory <<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download app content <<<<<<<\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app

echo -e "\e[36m>>>>>>> Unzip app content <<<<<<<\e[0m"
unzip /tmp/user.zip

echo -e "\e[36m>>>>>>> Install NodeJS Dependencies<<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>> Create application Directory <<<<<<<\e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service

echo -e "\e[36m>>>>>>> Start user service <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

echo -e "\e[36m>>>>>>> Copy mongo repo <<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>> Install mongoDB client <<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>> load schema <<<<<<<\e[0m"
mongo --host MONGODB-SERVER-IPADDRESS </app/schema/user.js