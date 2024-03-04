#scriptpath="$PWD"
mysql_root_passwd=$1
echo disable default NodeJS Version module
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?
echo enable default NodeJs Version module
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?
echo Install NodeJs
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo adding application user
useradd expense &>>/tmp/expense.log
echo $?

echo Copy Backend Service file
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log 
echo $?
#remove the /app by using below cmd before executing .i.e first iteration will work ,next iterations it wont work.
echo clean the old content
rm -rf /app &>>/tmp/expense.log
echo $?

echo make a directory
mkdir /app &>>/tmp/expense.log 
echo $?

echo download backend zip file
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>/tmp/expense.log
echo $?

echo move to the specific directory and unzip the file
cd /app &>>/tmp/expens.log
unzip  /tmp/backend.zip &>>/tmp/expense.log
echo $?

echo install npm
cd /app &>>/tmp/expens.log
npm install &>>/tmp/expense.log 
echo $?

echo start backend service
systemctl daemon-reload &>>/tmp/expense.log 
systemctl enable backend &>>/tmp/expense.log 
systemctl start backend &>>/tmp/expense.log 
echo $?

echo Install MySQL Client
dnf install mysql -y &>>/tmp/expense.log
echo $?

echo Install Load Schema
mysql -h 172.31.4.183 -uroot -p${mysql_root_passwd} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?
