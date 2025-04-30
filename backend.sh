mysql_root_pwd=$1

echo Disable default nodejs
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

echo Enable node version 20
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

echo Install node js
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo create a new user expense
useradd expense &>>/tmp/expense.log
echo $?

echo copy backend service to specific path
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

echo make a directory with the name app
mkdir /app &>>/tmp/expense.log
echo $?

echo Download backend zip file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip  &>>/tmp/expense.log
echo $?

echo Extract App content
cd /app  &>>/tmp/expense.log
unzip /tmp/backend.zip  &>>/tmp/expense.log
echo $?

echo Install npm dependencies
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

echo Load the backend service
systemctl daemon-reload  &>>/tmp/expense.log
echo $?

echo Enable backend service
systemctl enable backend  &>>/tmp/expense.log
echo $?

echo Start backend service
systemctl start backend  &>>/tmp/expense.log
echo $?

echo Install mysqlclient to load schema into mysql-server
dnf install mysql -y     &>>/tmp/expense.log
echo $?

echo To Load backend schema to mysql-server
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