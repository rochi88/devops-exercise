DROP DATABASE IF EXISTS mydb;

CREATE DATABASE mydb;

USE mydb;

DROP TABLE IF EXISTS todos;

CREATE TABLE todos ( 
  id INT NOT NULL AUTO_INCREMENT, 
  data LONGTEXT NOT NULL, 
  completed BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY (id) 
);

INSERT INTO todos (data) VALUES ('Write project code');
INSERT INTO todos (data) VALUES ('Test project code');
INSERT INTO todos (data) VALUES ('Submit project code');