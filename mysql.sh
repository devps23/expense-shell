source common.sh
mysql_root_user=$1
mysql_root_password=$2

print_task_heading "Install mysql-server"
dnf install mysql-server -y  &>>/tmp/expense.log
checkStatus $?

print_task_heading "Enable mysqld"
systemctl enable mysqld  &>>/tmp/expense.log
checkStatus $?

print_task_heading "Start mysqld"
systemctl start mysqld  &>>/tmp/expense.log
checkStatus $?

print_task_heading "set username and password"
mysql_secure_installation --set-${mysql_root_user}-pass ${mysql_root_password} &>>/tmp/expense.log
checkStatus $?