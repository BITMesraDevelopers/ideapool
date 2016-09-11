# Ideapool

## DB Setup

Log in to MariaDB / MySQL as root and do this:

```
CREATE USER 'ideapool_admin'@'localhost' IDENTIFIED BY 'yourpasshere';
CREATE DATABASE ideapool_dev;
CREATE DATABASE ideapool_test;
CREATE DATABASE ideapool_prod;
GRANT ALL PRIVILEGES ON ideapool_dev.* TO 'ideapool_admin'@'localhost';
GRANT ALL PRIVILEGES ON ideapool_test.* TO 'ideapool_admin'@'localhost';
GRANT ALL PRIVILEGES ON ideapool_prod.* TO 'ideapool_admin'@'localhost';
```

## Serve

Serve using `rails s`.
