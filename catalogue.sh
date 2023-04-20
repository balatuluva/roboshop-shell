echo -e "\e[36m>>>>>>> Configuring NodeJS repos <<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[36m>>>>>>> Install NodeJS <<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[36m>>>>>>> Add Application User <<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create Application Directory <<<<<<<\e[0m"
rm -rf /app
mkdir /app
cd /app

echo -e "\e[36m>>>>>>> Download App content <<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[36m>>>>>>> Unzip app content <<<<<<<\e[0m"
unzip /tmp/catalogue.zip

echo -e "\e[36m>>>>>>> Install NodeJS dependencies <<<<<<<\e[0m"
npm install

echo -e "\e[36m>>>>>>> Copy catalogue systemD file <<<<<<<\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[36m>>>>>>> Start catalogue service <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue

echo -e "\e[36m>>>>>>> Copy Mongodb repo <<<<<<<\e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[36m>>>>>>> Install mongoDB client <<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[36m>>>>>>> load schema <<<<<<<\e[0m"
mongo --host mongodb.gehana26.online </app/schema/catalogue.js