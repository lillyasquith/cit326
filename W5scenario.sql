--SHOW 1
--a.	Verify that you have a recent backup of your bowling database or take a new one.
SELECT bs.database_name,
    backuptype = CASE 
        WHEN bs.type = 'D' AND bs.is_copy_only = 0 THEN 'Full Database'
        WHEN bs.type = 'D' AND bs.is_copy_only = 1 THEN 'Full Copy-Only Database'
        WHEN bs.type = 'I' THEN 'Differential database backup'
        WHEN bs.type = 'L' THEN 'Transaction Log'
        WHEN bs.type = 'F' THEN 'File or filegroup'
        WHEN bs.type = 'G' THEN 'Differential file'
        WHEN bs.type = 'P' THEN 'Partial'
        WHEN bs.type = 'Q' THEN 'Differential partial'
        END + ' Backup',
    CASE bf.device_type
        WHEN 2 THEN 'Disk'
        WHEN 5 THEN 'Tape'
        WHEN 7 THEN 'Virtual device'
        WHEN 9 THEN 'Azure Storage'
        WHEN 105 THEN 'A permanent backup device'
        ELSE 'Other Device'
        END AS DeviceType,
    bms.software_name AS backup_software,
    bs.recovery_model,
    bs.compatibility_level,
    BackupStartDate = bs.Backup_Start_Date,
    BackupFinishDate = bs.Backup_Finish_Date,
    LatestBackupLocation = bf.physical_device_name,
    backup_size_mb = CONVERT(DECIMAL(10, 2), bs.backup_size / 1024. / 1024.),
    compressed_backup_size_mb = CONVERT(DECIMAL(10, 2), bs.compressed_backup_size / 1024. / 1024.),
    database_backup_lsn, -- For tlog and differential backups, this is the checkpoint_lsn of the FULL backup it is based on.
    checkpoint_lsn,
    begins_log_chain,
    bms.is_password_protected
FROM msdb.dbo.backupset bs
LEFT JOIN msdb.dbo.backupmediafamily bf
    ON bs.[media_set_id] = bf.[media_set_id]
INNER JOIN msdb.dbo.backupmediaset bms
    ON bs.[media_set_id] = bms.[media_set_id]
WHERE bs.backup_start_date > DATEADD(MONTH, - 2, sysdatetime()) --only look at last two months
ORDER BY bs.database_name ASC,
    bs.Backup_Start_Date DESC;

--b.	Write an SQL ALTER TABLE statement to add an e-mail address column alter statement to add an email address column of length 50 to the "bowlers" table.

use BowlingLeagueExample;
select * from bowling_new1.Bowlers;

SELECT b.BowlerFirstName, b.BowlerLastName, LOWER(CONCAT(TRIM(b.BowlerFirstName),TRIM(b.BowlerLastName), '@gmail.com')) AS EmailAddress
	FROM bowling_new1.Bowlers AS b
	WHERE 1=1;

ALTER TABLE bowling_new1.Bowlers
ADD EmailAdress varchar(50);

--ALTER TABLE bowling_new1.Bowlers
--DROP COLUMN EmailAdresses;

--c.	Write an UPDATE statement (not INSERT) to simulate email addresses for each customer using their first name plus last name @gmail.com (for example, row 1 should be barbarafournier@gmail.com ). 

UPDATE b 
SET b.EmailAdress = LOWER(CONCAT(TRIM(b.BowlerFirstName),TRIM(b.BowlerLastName), '@gmail.com'))
FROM bowling_new1.Bowlers AS b;

--SHOW 2: 
--a.	Create a new login/user for a junior employee. Name it bob_the_scorekeeper and use a password of your choice.
--b.	Create a view that displays all other information in the "bowlers" table except for street address, phone number and email address for each bowler. The view must be created using the same schema name as the bowling table. Grant access to this view to the new user created in step 1. 
--NOTE: Pay close attention to what access the new user should have based on the instructions. Also. generate and save your scripts from steps 1-3 so you can run them on the class server in step 4!

--CREATE VIEW bowling_new1.BowlersTest1
--AS 
--SELECT BowlerID, BowlerLastName, BowlerFirstName, BowlerMiddleInit, BowlerCity, BowlerState, BowlerZip, TeamID
--FROM  bowling_new1.Bowlers;

