app_dir=/usr/share/nginx/html
component=frontend
source common.sh

print_task_heading "Install nginx"
dnf install nginx -y &>>Log
checkStatus $?

print_task_heading "Enable Nginx"
systemctl enable nginx &>>Log
checkStatus $?

print_task_heading "Start nginx"
systemctl start nginx &>>Log
checkStatus $?

print_task_heading "Copy reverse proxy configuration"
cp expense.conf /etc/nginx/default.d/expense.conf &>>Log
checkStatus $?



app_code

print_task_heading "Restart nginx"
systemctl restart nginx &>>Log
checkStatus $?




