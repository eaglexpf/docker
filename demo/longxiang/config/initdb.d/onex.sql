create user longxiang identified by '123456';

CREATE DATABASE IF NOT EXISTS longxiang DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci;

grant all privileges on longxiang.* to longxiang@'%' identified by '123456';
flush privileges;