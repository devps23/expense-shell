echo "Install nginx"
dnf install nginx -y &>>/tmp/expense.log
echo $?

echo "Enable Nginx"
systemctl enable nginx &>>/tmp/expense.log
echo $?

echo "Start nginx"
systemctl start nginx &>>/tmp/expense.log
echo $?

echo "Copy reverse proxy configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
echo $?

echo "Remove default content"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
echo $?

echo "Dowmload frontend app code"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
echo $?

echo "Move to specific path"
cd /usr/share/nginx/html &>>/tmp/expense.log
echo $?

echo "Unzip frontend code in specific path"
unzip /tmp/frontend.zip &>>/tmp/expense.log
echo $?

echo "Restart nginx"
systemctl restart nginx &>>/tmp/expense.log
echo $?




