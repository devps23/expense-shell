# eks-argocd-helm-chart

Output Redirector
==================
Output: 1>
Error: 2>

ex:
1>/tmp/expense.log
2>/tmp/expense.log

to redirect both error and ouput we can use &>

ex: &>/tmp/expense.log
in the above example &> override the previous and display latest , but here we required all output from beginning to the
end
so for this we have to use &>>

ex: &>>/tmp/expense.log , displays output from beginning to the end.

[//]: # (Example for multi line comments in the shell)
<<EOF
Print
Variables

- special variables
- exit status
  Functions
  DRY
  Password not hardcoding

EOF

here <<EOF EOF this is the multi line comment


ex:
===
x=10
if [ $x -eq 10 ]; then
echo $x is greater than 10
else
echo $x is less than 10

fi

ex:2
====
x=$1
if [ $x -eq 10 ]; then
echo $x is greater than 10
else
echo $x is less than 10

fi

here $1 means pass value dynamically like bash sample.sh 1

ex:3
=====

x=$1

if [ $x -eq 10 ]; then
echo $x is greater than 10
else
echo $x is less than 10

fi

here $1 means pass value dynamically , unexpectedly we are not pass any value at that time x value is empty right
so here check x is empty or value

if [ -z $x ] ; then
echo Input is missing
fi

if [ $x -eq 10 ]; then
echo $x is greater than 10
else
echo $x is less than 10

fi

here , if the input is missing shouldn't move to next step, so we have to use exit

if [ -z $x ] ; then
echo Input is missing
exit
fi

if [ $x -eq 10 ]; then
echo $x is greater than 10
else
echo $x is less than 10

fi

here, if the input is missing we have to exit explicitly with value ,exit 0 means by default success, exit 1 so here we
have to provide exit 1 explictly


functions:
===========
example(){
echo "Hello world"
}
example // call the function with name

# Functions have its own special variables

example1()
{
echo "Value of 1 $1 - $1"
echo "values of 2 $* - $*"
echo "values of 3 $# - $#"
}

$1 ---- first value
$* ----- all values
$# -----count number of values


Colors:
=======
Color Printing

Colors
Red -- 31
Green -- 32
Yellow -- 33
Blue -- 34
Magenta -- 35
Cyan -- 36

Syntax: echo -e "\e[COLmMESSAGE]\e[0m"
here -e enable
\e[COLm - start color
MESSAGE - Message to be printed to the color
\e[0m - disable the color

echo -e "\e[31m This is RedColor\e[0m"
echo -e "\e[32m This is Green color\e[0m"
echo -e "\e[33m This is Yellow color\e[0m"
echo -e "\e[33m This is Blue color\e[0m"
echo -e "\e[34m This is Magenta color\e[0m"
echo -e "\e[35m This is Cyan color\e[0m"

    





