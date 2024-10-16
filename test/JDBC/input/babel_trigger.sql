-- a simple test
create table testing1(col nvarchar(60))
GO

create trigger notify on testing1 after insert
as
begin
  SELECT 'trigger invoked'
end
GO

insert into testing1 (col) select N'Muffler'
GO

drop trigger notify
GO

-- test drop trigger if exists
create trigger notify on testing1 after insert
as
begin
  SELECT 'trigger invoked'
end
GO

drop trigger if exists notify
GO

drop trigger if exists notify
GO

-- test comma separator
create trigger notify on testing1 after insert, delete
as
begin
  SELECT 'trigger invoked'
end
GO

insert into testing1 (col) select N'Apple'
GO

delete from testing1 where col = N'Apple'
GO

drop trigger notify
GO

-- test inserted and deleted transition tables
CREATE TABLE products(
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL
)
GO

CREATE TABLE product_audits(
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
)
GO

CREATE TRIGGER trg_product_audit
ON products
AFTER INSERT
AS
BEGIN
    INSERT INTO product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        'INS'
    FROM
        inserted i
END
GO

INSERT INTO products(
	product_id,
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
	1,
    'Test product',
    1,
    1,
    2018,
    599
)
GO

SELECT * FROM PRODUCT_AUDITS
GO

drop trigger trg_product_audit
GO

-- clean up
drop table testing1
GO
drop table product_audits
GO
drop table products
GO

-- CARRY OUT THE SAME TESTS WITH THE FOR KEYWORD --

-- a simple test
create table testing1(col nvarchar(60))
GO

create trigger notify on testing1 for insert
as
begin
  SELECT 'trigger invoked'
end
GO

insert into testing1 (col) select N'Muffler'
GO

drop trigger notify
GO

-- test drop trigger if exists
create trigger notify on testing1 for insert
as
begin
  SELECT 'trigger invoked'
end
GO

drop trigger if exists notify
GO

drop trigger if exists notify
GO

-- test comma separator
create trigger notify on testing1 for insert, delete
as
begin
  SELECT 'trigger invoked'
end
GO

insert into testing1 (col) select N'Apple'
GO

delete from testing1 where col = N'Apple'
GO

drop trigger notify
GO

-- test inserted and deleted transition tables
CREATE TABLE products(
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL
)
GO

CREATE TABLE product_audits(
    product_id INT NOT NULL,
    product_name VARCHAR(255) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DEC(10,2) NOT NULL,
    operation CHAR(3) NOT NULL,
    CHECK(operation = 'INS' or operation='DEL')
)
GO

CREATE TRIGGER trg_product_audit
ON products
FOR INSERT
AS
BEGIN
    INSERT INTO product_audits(
        product_id, 
        product_name,
        brand_id,
        category_id,
        model_year,
        list_price, 
        operation
    )
    SELECT
        i.product_id,
        product_name,
        brand_id,
        category_id,
        model_year,
        i.list_price,
        'INS'
    FROM
        inserted i
END
GO

INSERT INTO products(
	product_id,
    product_name, 
    brand_id, 
    category_id, 
    model_year, 
    list_price
)
VALUES (
	1,
    'Test product',
    1,
    1,
    2018,
    599
)
GO

SELECT * FROM PRODUCT_AUDITS
GO

drop trigger trg_product_audit
GO

-- Test drop trigger without table name --
-- First, test that triggers must have unique names
create trigger notify on testing1 after insert
as
begin
  SELECT 'trigger invoked'
end
GO

create table testing2(col nvarchar(60))
GO

create trigger notify on testing2 after insert
as
begin
  SELECT 'trigger invoked'
end
GO

drop table testing2
GO

-- Now, test that drop trigger works without tablename
drop trigger notify
GO

-- Test that drop trigger statement on non-existent trigger throws error
drop trigger notify
GO
drop trigger if exists notify
GO

-- Test that dropping a table with triggers defined on it succeeds
create table testTbl(colA int not null primary key, colB varchar(20))
GO

create trigger trig1 on testTbl after insert
as
begin
	SELECT 'trigger invoked'
end
GO

create trigger trig2 on testTbl after insert
as
begin
	SELECT 'trigger2 invoked'
end
GO

drop table testTbl
GO

-- Test 'NOT FOR REPLICATION' syntax
create trigger notify on testing1 after insert
NOT FOR REPLICATION
as
begin
  SELECT 'trigger invoked'
end
GO

insert into testing1 (col) select N'Muffler'
GO

drop trigger notify
GO

-- test trigger function's schema
create schema babel_trigger_sch1;
GO

create table babel_trigger_sch1.babel_trigger_t1(a int, b int);
GO

create trigger babel_trigger_sch1.babel_trigger_trig1 on babel_trigger_sch1.babel_trigger_t1 after insert as select 1;
GO

-- if we don't specify the schema name of trigger
create trigger babel_trigger_trig2 on babel_trigger_sch1.babel_trigger_t1 after insert as select 1;
GO

create trigger babel_trigger_trig3 on babel_trigger_t1 after insert as select 1;
GO

create trigger babel_trigger_sch1.babel_trigger_trig4 on babel_trigger_t1 after insert as select 1;
GO

select name,schema_name(schema_id) from sys.objects where name in ('babel_trigger_trig1','babel_trigger_trig2','babel_trigger_trig3','babel_trigger_trig4') order by name;
GO

CREATE TABLE #babel_2177(id int)
go

-- will fail and print error when trying to create trigger on temp table 
CREATE TRIGGER trigger_babel_2177 ON #babel_2177
AFTER INSERT
AS
	INSERT into #babel_2177 VALUES (7)
go

drop table #babel_2177;
GO

-- clean up
drop trigger babel_trigger_sch1.babel_trigger_trig1
GO
drop trigger babel_trigger_sch1.babel_trigger_trig2
GO
drop table babel_trigger_sch1.babel_trigger_t1
GO
drop schema babel_trigger_sch1
GO
drop table testing1
GO
drop table product_audits
GO
drop table products
GO