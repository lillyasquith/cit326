--SHOW 1: The owner of the bowling league, Karl scenario
--Choose a table 
select count(*) from bowling_new1.Teams;
select * from bowling_new1.Teams;

--Start with a Full backup of the DB BowlingLeagueExample in Full recovery model
BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\fullbowling.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--set Recovery Model to simple
alter database [BowlingLeagueExample] set recovery simple 
go

-- take a Full backup of the BD in Simple recovery model
BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\simplewithfullbowling.bak' WITH NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--take a Differental backup in Simple recovery model
BACKUP DATABASE [BowlingLeagueExample] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup\simpledifferentialbowling.bak' WITH  DIFFERENTIAL , NOFORMAT, NOINIT,  NAME = N'BowlingLeagueExample-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--populate some more info
insert into bowling_new1.Teams values ('11', 'Eagles', '9')
--insert into bowling_new1.Teams values ('12', 'Wolves', '6')

--verify inserts
select count(*) from bowling_new1.Teams;
select * from bowling_new1.Teams;

--delete Eagles team
delete bowling_new1.Teams where TeamName = 'Eagles';
--delete bowling_new1.Teams where TeamName = 'Wolves';

--verify the record was deleted
select count(*) from bowling_new1.Teams;
select * from bowling_new1.Teams;

--restore

--check info after restore
select count(*) from bowling_new1.Teams;
select * from bowling_new1.Teams;






