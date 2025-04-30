source common.sh

print_task_heading "Install nginx"
dnf install nginx -y &>>/tmp/expense.log
checkStatus $?

print_task_heading "Enable Nginx"
systemctl enable nginx &>>/tmp/expense.log
checkStatus $?

print_task_heading "Start nginx"
systemctl start nginx &>>/tmp/expense.log
checkStatus $?

print_task_heading "Copy reverse proxy configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>/tmp/expense.log
checkStatus $?

print_task_heading "Remove default content"
rm -rf /usr/share/nginx/html/* &>>/tmp/expense.log
checkStatus $?

print_task_heading "Dowmload frontend app code"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>/tmp/expense.log
checkStatus $?

print_task_heading "Move to specific path"
cd /usr/share/nginx/html &>>/tmp/expense.log
checkStatus $?

print_task_heading "Unzip frontend code in specific path"
unzip /tmp/frontend.zip &>>/tmp/expense.log
checkStatus $?

print_task_heading "Restart nginx"
systemctl restart nginx &>>/tmp/expense.log
checkStatus $?




