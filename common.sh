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