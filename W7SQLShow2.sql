
--lists the permissions explicitly granted or denied to server principals.
--SELECT pr.principal_id, pr.name, pr.type_desc,   
--    pe.state_desc, pe.permission_name   
--FROM sys.server_principals AS pr   
--JOIN sys.server_permissions AS pe   
--    ON pe.grantee_principal_id = pr.principal_id; 

--Return list of server-role members??
--SELECT	roles.principal_id							AS RolePrincipalID
--	,	roles.name									AS RolePrincipalName
--	,	server_role_members.member_principal_id		AS MemberPrincipalID
--	,	members.name								AS MemberPrincipalName
--FROM sys.server_role_members AS server_role_members
--INNER JOIN sys.server_principals AS roles
--    ON server_role_members.role_principal_id = roles.principal_id
--INNER JOIN sys.server_principals AS members 
--    ON server_role_members.member_principal_id = members.principal_id  
--;

--B. Azure SQL Database: Listing all principals (SQL authentication) which are members of a server-level role??
--SELECT
--		sql_logins.principal_id			AS MemberPrincipalID
--	,	sql_logins.name					AS MemberPrincipalName
--	,	roles.principal_id				AS RolePrincipalID
--	,	roles.name						AS RolePrincipalName
--FROM sys.server_role_members AS server_role_members
--INNER JOIN sys.server_principals AS roles
--    ON server_role_members.role_principal_id = roles.principal_id
--INNER JOIN sys.sql_logins AS sql_logins 
--    ON server_role_members.member_principal_id = sql_logins.principal_id
--;  
--GO  



--create a query to list the name of each account with sysadmin privileges and the last modified date of that login --other ways around
--SELECT *
--FROM sys.server_role_members AS server_role_members
--INNER JOIN sys.server_principals AS roles
--    ON server_role_members.role_principal_id = roles.principal_id
--INNER JOIN sys.sql_logins AS sql_logins 
--    ON server_role_members.member_principal_id = sql_logins.principal_id
--;  
--GO  

--SELECT sql_logins.name AS AccountName, roles.name AS ServerRole, sql_logins.modify_date AS LastModifiedDate
--FROM 
--	sys.server_role_members AS server_role_members
--INNER JOIN 
--	sys.server_principals AS roles
--    ON server_role_members.role_principal_id = roles.principal_id
--INNER JOIN 
--	sys.sql_logins AS sql_logins 
--    ON server_role_members.member_principal_id = sql_logins.principal_id
--;  
--GO



--SHOW2: START HERE
--create a query to list the name of each account with sysadmin privileges and the last modified date of that login
SELECT sp.name AS AccountName,
	   sr.name AS ServerRole,
	   sp.modify_date AS LastModifiedDate
FROM
    sys.server_principals sp
JOIN
    sys.server_role_members srm ON sp.principal_id = srm.member_principal_id
JOIN
    sys.server_principals sr ON srm.role_principal_id = sr.principal_id
WHERE
    sr.name = 'sysadmin'
    AND sp.type_desc = 'SQL_LOGIN'
	AND sp.modify_date < '2024-02-23';


--Set up a custom audit job that runs daily and inserts the data from your query into a new table each time

--step1
DROP TABLE IF EXISTS custom_test.sysadmin_logins_$(ESCAPE_NONE(DATE))

CREATE TABLE custom_test.sysadmin_logins_$(ESCAPE_NONE(DATE))
	(
	AccountName varchar(50) NULL,
	ServerRole varchar(50) NULL,
	LastModifiedDate datetime
	);

--step2
INSERT INTO custom_test.sysadmin_logins_$(ESCAPE_NONE(DATE))

SELECT sp.name AS AccountName,
	   sr.name AS ServerRole,
	   sp.modify_date AS LastModifiedDate
FROM
    sys.server_principals sp
JOIN
    sys.server_role_members srm ON sp.principal_id = srm.member_principal_id
JOIN
    sys.server_principals sr ON srm.role_principal_id = sr.principal_id
WHERE
    sr.name = 'sysadmin'
    AND sp.type_desc = 'SQL_LOGIN';