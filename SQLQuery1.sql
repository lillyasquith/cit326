--1.In your new job, you need to be aware of how many tables you must manage in each database. One way to do this is:
--Run a query using "sys.tables" within each database to discover all user tables (type = ‘U’) in the three databases (WideWorldImporters, Bowling, and your chosen DB).

--HINT: Notice at the top of the sys.tables documentation that some data dictionary columns, such as ‘type,’ are inherited from sys.objects. You do not need to join to this table, but it is something to be aware of. All database ‘objects’ share these inherited attributes.
 
-- SHOW 1: Your queries and query results. The results should include the names of all user tables in each database, when each was created, and last modified date.

USE WideWorldImporters
--select * from sys.tables;
SELECT t.name, t.create_date, t.modify_date
FROM sys.tables AS t
ORDER BY t.name;

USE BowlingLeagueExample
--select * from sys.tables;
SELECT t.name, t.create_date, t.modify_date
FROM sys.tables AS t
ORDER BY t.name;

USE RecipesExample
--select * from sys.tables;
--select * from sys.master_files;
--select * from sys.databases;
SELECT t.name, t.create_date, t.modify_date
FROM sys.tables AS t
ORDER BY t.name;


--2.During the job interview, you were told that the company recently ran into a customer whose name length exceeded the defined column size. You want to make sure this never happens again. Start by identifying all columns that contain any type of name data. One way to do this is:

--Run a query using “sys.columns” and "sys.tables" in the same three databases (one query for each) to identify all columns which include the string "name" within the column name. We should also show the currently configured maximum length for these columns. You should also display the tables each column belongs to.

--HINT: In your SQL, you will need to use the LIKE operator and wildcards to see all relevant columns (such as first_name, customerName, etc.). The wildcards should also consider “name” may be in the middle or at the beginning of the column name.  
--HINT: You will need to perform a two table JOIN (video review on joins). Keep in mind, many thousands of developers and administrators worldwide are using the data dictionary to answer these types of questions. You can easily do web searches on how to use and join these system catalog views. These data dictionary tables and views are similar for all installations of SQL Server. Try 
--o	searches such as ‘sql server sys.columns join sys.tables list all columns for each table.’ Also, go read the documentation for sys.columns to see what ‘object_ID’ is!

--SHOW 2: Your queries and query results for each of the three databases. The results should include: the name of the column, the name of the table the column belongs to, and the current maximum length for that column. 

USE WideWorldImporters
--select * from sys.tables;
--select * from sys.columns;
SELECT c.name AS ColumnName, t.name AS TableName, c.max_length
FROM sys.columns AS c
	JOIN sys.tables AS t
	ON t.object_id = c.object_id
WHERE c.name LIKE '%name%'
ORDER BY t.name, c.name;

USE BowlingLeagueExample
--select * from sys.tables;
--select * from sys.columns;
SELECT c.name AS ColumnName, t.name AS TableName, c.max_length
FROM sys.columns AS c
	JOIN sys.tables AS t
	ON t.object_id = c.object_id
WHERE c.name LIKE '%name%'
ORDER BY t.name, c.name;

USE RecipesExample
--select * from sys.tables;
--select * from sys.columns;
SELECT c.name AS ColumnName, t.name AS TableName, c.max_length
FROM sys.columns AS c
	JOIN sys. tables AS t
	ON t.object_id = c.object_id
WHERE c.name LIKE '%name%'
ORDER BY t.name, c.name;

--3.It is also important to know which databases are your “heavy hitters” in terms of space and resource consumption. 
--Run queries using the same three databases you previously explored to find out how large each database is and where the largest files are stored. We should also convert the file sizes shown in the data dictionary to MB.

--HINT: Take a look at the system catalog views regarding databases and files. Try querying them or reading the documentation to determine which to use. You will have to do some conversion, because the “size” column lists a different type of measurement in the documentation. Read it carefully as well as this page for database storage measurements.

--SHOW 3: 
--i.	Queries and results which list the file name, file location, and file size (as listed in the database_files catalog view without conversion) of any file greater than or equal to size 1024.
--ii.	Queries and results which list the full size of each database in MB. You will have to add the size for each database file using the SUM function and then include the calculations from the hint above. (Video review on using math in your SQL.)
--iii.	Show the screen in your Windows explorer where you navigate to the folder which holds the files (listed in your query from part i). Identify them and compare them to your results from steps i and ii. Your calculations from step ii should match what you see in Windows!

USE master
--select * from sys.master_files;
--select * from sys.databases;
SELECT mf.name,d. name, mf.physical_name AS FileLocation, mf.size, ( mf.size * 8 ) / 1024 AS SizeMB
FROM sys.master_files AS mf
	JOIN sys.databases AS d
	ON d.database_id = mf.database_id
WHERE 1=1
AND mf.size >= 1024
AND d.name IN ('WideWorldImporters', 'BowlingLeagueExample', 'RecipesExample');

USE master
SELECT d.name, SUM(( mf.size * 8 ) / 1024) AS SizeMB
FROM sys.master_files AS mf
	JOIN sys.databases AS d
	ON d.database_id = mf.database_id
WHERE d.name IN ('WideWorldImporters', 'BowlingLeagueExample', 'RecipesExample')
GROUP BY d.name;



/* 4.Take a closer look at any of the catalog tables/views mentioned in the week 2 preparation post (Always read the preparation posts!). Read through the official Microsoft documentation or the book to find out what the columns mean. Find two more items that could be of interest to you in administering these databases. 

SHOW 4: The two items you discovered in the data dictionary and the corresponding query results. Explain why you believe these would be important to keep an eye on. */

--Note: to find Null values
USE BowlingLeagueExample
--select * from sys.tables;
--select * from sys.columns;
SELECT t.name AS TableName, c.name AS ColumnName, c.is_nullable
FROM sys. tables AS t
	JOIN sys.columns AS c
	ON c.object_id =t.object_id
WHERE
c.is_nullable = 1;

--Note: To see each database, Multi_userAccess,state, recovery_model
USE master
--select * from sys.databases;
SELECT d.physical_database_name, d.user_access_desc, d.state_desc, d.recovery_model_desc
FROM sys.databases AS d;