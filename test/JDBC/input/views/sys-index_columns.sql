DROP TABLE IF EXISTS sys_index_columns
GO

CREATE TABLE sys_index_columns (
	sic_name VARCHAR (50),
	sic_surname VARCHAR (50)
)
GO

CREATE INDEX sic_test_index
ON sys_index_columns (sic_name)
GO

SELECT COUNT(*) FROM sys.index_columns WHERE object_id = OBJECT_ID('sys_index_columns')
GO

DROP TABLE IF EXISTS sys_index_columns
GO

CREATE DATABASE db1;
GO

USE db1
GO

CREATE TABLE rand_name1(rand_col1 int DEFAULT 1);
GO

CREATE INDEX idx_rand_name1 ON rand_name1(rand_col1);
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name1';
GO

USE master;
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name1';
GO

CREATE TABLE rand_name2(rand_col2 int DEFAULT 1);
GO

CREATE INDEX idx_rand_name2 ON rand_name2(rand_col2);
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name2';
GO

USE db1
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name2';
GO

DROP TABLE rand_name1;
GO

USE master
GO

DROP TABLE rand_name2;
GO

DROP DATABASE db1;
GO

CREATE DATABASE db1 COLLATE BBF_Unicode_CP1_CI_AI;
GO

USE db1
GO

CREATE TABLE rand_name1(rand_col1 int DEFAULT 1);
GO

CREATE INDEX idx_rand_name1 ON rand_name1(rand_col1);
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name1';
GO

USE master;
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name1';
GO

CREATE TABLE rand_name2(rand_col2 int DEFAULT 1);
GO

CREATE INDEX idx_rand_name2 ON rand_name2(rand_col2);
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name2';
GO

USE db1
GO

SELECT count(*) FROM  sys.index_columns idx JOIN sys.tables tab ON idx.object_id = tab.object_id WHERE tab.name = 'rand_name2';
GO

DROP TABLE rand_name1;
GO

USE master
GO

DROP TABLE rand_name2;
GO

DROP DATABASE db1;
GO