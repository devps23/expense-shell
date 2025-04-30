source common.sh
app_dir=/app
component=backend
mysql_root_pwd=$1

if [ -z ${mysql_root_pwd} ]; then
  echo "Mysql root password is missing"
  exit 1
fi

print_task_heading "Disable default nodejs"
dnf module disable nodejs -y &>>$Log
checkStatus $?

print_task_heading "Enable node version 20"
dnf module enable nodejs:20 -y &>>$Log
checkStatus $?

print_task_heading "Install node js"
dnf install nodejs -y &>>$Log
checkStatus $?

print_task_heading "create a new user expense"
#if id "expense" &>/dev/null; then
#  echo "user exists"
#else
#  useradd expense $Log
#fi
id expense
if [ $? -ne 0 ]; then
   echo "user not exists"
   useradd expense &>>$Log
   exit 1
fi
checkStatus $?

print_task_heading "copy backend service to specific path"
cp backend.service /etc/systemd/system/backend.service &>>$Log
checkStatus $?

print_task_heading "Remove a directory"
rm -rf /app
checkStatus $?


app_code


print_task_heading "Install npm dependencies"
cd /app &>>$Log
npm install &>>$Log
checkStatus $?

print_task_heading "Load the backend service"
systemctl daemon-reload  &>>$Log
checkStatus $?

print_task_heading "Enable backend service"
systemctl enable backend  &>>$Log
checkStatus $?

print_task_heading "Start backend service"
systemctl start backend  &>>$Log
checkStatus $?

print_task_heading "Install mysqlclient to load schema into mysql-server"
dnf install mysql -y  &>>$Log
checkStatus $?

print_task_heading "To Load backend schema to mysql-server"
mysql -h 172.31.28.220 -uroot -p${mysql_root_pwd} < /app/schema/backend.sql  &>>$Log
checkStatus $?


# 1>/tmp/expense.log  ---->redirect output into a file
# 2>/tmp/error.log    -----> redirect error into a file
# to redirect both output and error into a file at a time we can use &>/tmp/expense.log
# &>/tmp/expense.log , if we use single '>' always it will override the content and displays last data/output
# to append each and every line content we use &>>/tmp/expense.log
# username and password should not hardcoded
# echo is a command which is used to display data/output/heading
# echo $? is status whether action can be performed or not
# echo $? if 0 success other than 0 failure
#DRY ---- code should not repeated
