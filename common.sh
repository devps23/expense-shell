Log=/tmp/expense.log
print_task_heading(){
  echo $1
  echo "**************** $1 ******************" &>>/tmp/expense.log
}
checkStatus(){
  echo "============== $1 =====================" &>>/tmp/expense.log
  if [ $1 -eq 0 ]; then
     echo -e "\e[32m SUCCESS\e[0m"
  else
    echo -e "\e[31m FAILURE\e[0m"
  fi

}
app_code(){

print_task_heading "Make a directory"
mkdir $app_dir &>>$Log
checkStatus $?

print_task_heading "Download app code"
curl -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/expense-$component-v2.zip  &>>$Log
checkStatus $?

print_task_heading "Extract App content"
cd $app_dir &>>$Log
unzip /tmp/$component.zip  &>>$Log
checkStatus $?
}