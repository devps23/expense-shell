dnf install nginx -y &>/tmp/expense.log
systemctl enable nginx &>/tmp/expense.log
systemctl start nginx &>/tmp/expense.log
cp expense.conf /etc/nginx/default.d/expense.conf 1>/tmp/expense.log
rm -rf /usr/share/nginx/html/* 1>/tmp/expense.log
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip 1>/tmp/expense.log
cd /usr/share/nginx/html 1>/tmp/expense.log
unzip /tmp/frontend.zip 1>/tmp/expense.log
systemctl restart nginx 1>/tmp/expense.log
