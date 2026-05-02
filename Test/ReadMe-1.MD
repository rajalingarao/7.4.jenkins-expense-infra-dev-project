What are the steps involved for Frontend, Backend, DB Servers for Expense Project?

Just to recollect all installation steps (Expense project steps):

# MySQL db server installation
1.	install mysql-server
2.	enable mysql-server
3.	start mysql-server
4.	changing the default root user's password

# Backend app server installation
1.	disable nodejs old version
2.	enable nodejs new version
3.	install nodejs
4.	create a user like expense and folder like ‘app’
5.	download application code
6.	change(switch) to ‘app’ folder 
7.	unzip the backend app
8.	install application dependencies
9.	setup systemd backend service
10.	load the backend service
11.	enable the backend service
12.	start the backend service
13.	install MySQL client 
14.	load the database schema into MySQL
15.	restart the backend service

# front web server
1.	install nginx
2.	enable nginx
3.	start nginx
4.	remove the default content form nginx server
5.	download the application code
6.	change(switch) to nginx conf path /usr/share/nginx/html
7.	unzip the application code
8.	create nginx reverse proxy configuration
9.	restart nginx server



