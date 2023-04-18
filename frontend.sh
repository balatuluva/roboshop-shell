yum install nginx -y
cp roboshop.conf /etc/nginx/default.d/roboshop.conf
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip /tmp/frontend.zip
systemctl restart nginx
systemctl enable nginx
