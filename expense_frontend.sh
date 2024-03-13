source common_print.sh
app_dir=/usr/share/nginx/html
component=frontend
print_heading "Install Nginx"
dnf install nginx -y &>>$LOG
print_status $?

print_heading "Start frontend service"
systemctl enable nginx &>>$LOG
systemctl start nginx &>>$LOG
print_status $?

print_heading "copy configuration into nginx config file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
print_status $?

App_task_changes

print_heading "Load the changes of configuration file"
systemctl restart nginx &>>$LOG
print_status $?

