echo -e "\e[36m>>>>>>> Install maven <<<<<<<\e[0m"
yum install maven -y

echo -e "\e[36m>>>>>>> Add user roboshop <<<<<<<\e[0m"
useradd roboshop

echo -e "\e[36m>>>>>>> Create app Directory <<<<<<<\e[0m"
rm -rf /app
mkdir /app

echo -e "\e[36m>>>>>>> Download app content <<<<<<<\e[0m"
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping.zip

echo -e "\e[36m>>>>>>> Extract app content <<<<<<<\e[0m"
cd /app
unzip /tmp/shipping.zip

echo -e "\e[36m>>>>>>> Download maven dependencies <<<<<<<\e[0m"
mvn clean package
mv target/shipping-1.0.jar shipping.jar

echo -e "\e[36m>>>>>>> Copy shipping repo file <<<<<<<\e[0m"
cp /home/centos/roboshop-shell/shipping.service /etc/systemd/system/shipping.service

echo -e "\e[36m>>>>>>> Install MySQL <<<<<<<\e[0m"
yum install mysql -y

echo -e "\e[36m>>>>>>> Load schema <<<<<<<\e[0m"
mysql -h mysql.gehana26.online -uroot -pRoboShop@1 < /app/schema/shipping.sql

echo -e "\e[36m>>>>>>> Start shipping service <<<<<<<\e[0m"
systemctl daemon-reload
systemctl enable shipping
systemctl restart shipping

