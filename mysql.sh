source common.sh
mysql_root_user=$1
mysql_root_password=$2

if [ -z mysql_root_user ]; then
   echo "mysql root user is missing"
   exit 1
fi

if [ -z mysql_root_password ]; then
   echo "mysql root password is missing"
   exit 1
fi
print_task_heading "Install mysql-server"
dnf install mysql-server -y  &>>Log
checkStatus $?

print_task_heading "Enable mysql server service"
systemctl enable mysqld  &>>Log
checkStatus $?

print_task_heading "Start mysql server service"
systemctl start mysqld  &>>Log
checkStatus $?

print_task_heading "set username and password"
echo 'show databases'| mysql -h 172.31.28.220 -uroot -pExpenseApp@1 &>>Log
if [ $? -ne 0 ]; then
 mysql_secure_installation --set-${mysql_root_user}-pass ${mysql_root_password} &>>Log
fi
checkStatus $?