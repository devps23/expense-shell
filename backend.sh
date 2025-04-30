mysql_root_pwd=$1

if [ -z ${mysql_root_pwd} ]; then
  echo "Mysql root password is missing"
  exit 1
fi

print_task_heading(){
  echo $1
  echo "**************** $1 ******************" &>>/tmp/expense.log
}
print_task_heading "Disable default nodejs"
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

print_task_heading "Enable node version 20"
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

print_task_heading "Install node js"
dnf install nodejs -y &>>/tmp/expense.log
echo $?

print_task_heading "create a new user expense"
useradd expense &>>/tmp/expense.log
echo $?

print_task_heading "copy backend service to specific path"
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

print_task_heading "Remove a directory"
rm -rf /app
echo $?

print_task_heading "make a directory with the name app"
mkdir /app &>>/tmp/expense.log
echo $?

print_task_heading "Download backend zip file"
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip  &>>/tmp/expense.log
echo $?

print_task_heading "Extract App content"
cd /app  &>>/tmp/expense.log
unzip /tmp/backend.zip  &>>/tmp/expense.log
echo $?

print_task_heading "Install npm dependencies"
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

print_task_heading "Load the backend service"
systemctl daemon-reload  &>>/tmp/expense.log
echo $?

print_task_heading "Enable backend service"
systemctl enable backend  &>>/tmp/expense.log
echo $?

print_task_heading "Start backend service"
systemctl start backend  &>>/tmp/expense.log
echo $?

print_task_heading "Install mysqlclient to load schema into mysql-server"
dnf install mysql -y  &>>/tmp/expense.log
echo $?

print_task_heading "To Load backend schema to mysql-server"
mysql -h 172.31.28.220 -uroot -p${mysql_root_pwd} < /app/schema/backend.sql  &>>/tmp/expense.log
echo $?


# 1>/tmp/expense.log  ---->redirect output into a file
# 2>/tmp/error.log    -----> redirect error into a file
# to redirect both output and error into a file at a time we can use &>/tmp/expense.log
# &>/tmp/expense.log , if we use single '>' always it will override the content and displays last data/output
# to append each and every line content we use &>>/tmp/expense.log
# username and password should not hardcoded
# echo is a command which is used to display data/output/heading
# echo $? is status whether action can be performed or not
# echo $? if 0 success other than 0 failure