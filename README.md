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

