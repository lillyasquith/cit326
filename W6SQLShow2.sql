use WideWorldImporters;

--Choose a table 
select * from Sales.SpecialDeals;
select count(*) from Sales.SpecialDeals;

--Start with a Full backup of the DB in Full recovery model
BACKUP DATABASE [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\fullwideworldimporters.bak' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--populate some more info
insert into Sales.SpecialDeals values (3, NULL,	NULL,	1,	NULL,	7,	'20% All Clearance',	'2024-01-01',	'2016-01-10',	NULL,	20.000,	NULL,	2,	'2024-12-31 16:00:00.0000000');
select GETDATE();
--2024-02-17 15:08:37.677

--take a Transaction Log back up 
BACKUP LOG [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\tlogimporters.trn' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO


--verify inserts
select * from Sales.SpecialDeals;
select count(*) from Sales.SpecialDeals;

--delete 
delete Sales.SpecialDeals where SpecialDealID = 3;
select GETDATE();
--2024-02-17 15:12:59.130


--verify the record was deleted
select * from Sales.SpecialDeals;
select count(*) from Sales.SpecialDeals;

--restore                                                                                                                         
USE [master]
ALTER DATABASE [WideWorldImporters] SET SINGLE_USER WITH ROLLBACK IMMEDIATE
BACKUP LOG [WideWorldImporters] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\WideWorldImporters_LogBackup_2024-02-17_15-15-06.bak' WITH NOFORMAT, NOINIT,  NAME = N'WideWorldImporters_LogBackup_2024-02-17_15-15-06', NOSKIP, NOREWIND, NOUNLOAD,  NORECOVERY ,  STATS = 5
RESTORE DATABASE [WideWorldImporters] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\fullwideworldimporters.bak' WITH  FILE = 1,  NORECOVERY,  NOUNLOAD,  REPLACE,  STATS = 5
RESTORE LOG [WideWorldImporters] FROM  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\tlogimporters.trn' WITH  FILE = 1,  NOUNLOAD,  STATS = 5,  STOPAT = N'2024-02-17T15:10:00'
ALTER DATABASE [WideWorldImporters] SET MULTI_USER

GO