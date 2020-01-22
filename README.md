## docker-python2-mssql

#### Python2 environment ready for deploy flask applications with uwsgi and Microsoft SQL Server client

This is Docker image I use for deploy python2 flask applications that use Microsoft SQL Server as database.
It uses pyodbc and SQLAlchemy for database related stuff.

Based on Debian 8. _Because Microsoft's mssql drivers refused to work properly in newest distros. This of course
**will** change in the future_

Python has already installed following packages and its dependacies:
```
Flask==1.1.1
Flask-JWT-Extended==3.24.1
Flask-RESTful==0.3.7
SQLAlchemy==1.3.10
uWSGI==2.0.18
pyodbc==4.0.27
suds==0.4
lxml==4.2.5
```

All you need to add is your application files, and simple script for start.

Here is example, for serving via uwsgi protocol. Use it with nginx.

`uwsgi --socket 0.0.0.0:5000 --protocol uwsgi --mount /yourapp=yourapp:app --manage-script-name`

nginx configuration:
```
location /yourapp
{
  uwsgi_pass your_app_ip:5000;
  include uwsgi_params;
}
```
