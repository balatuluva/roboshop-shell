yum install nginx -y
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
unzip /tmp/frontend.zip

# some file needs to be created

systemctl restart nginx
systemctl enable nginx
