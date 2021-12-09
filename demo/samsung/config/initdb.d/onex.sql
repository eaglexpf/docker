create user samsung identified by '123456';

CREATE DATABASE IF NOT EXISTS samsung DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;

grant all privileges on samsung.* to samsung@'%' identified by '123456';
flush privileges;