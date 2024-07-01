
--step1
DROP TABLE IF EXISTS custom_audit.failed_logins_$(ESCAPE_NONE(DATE))

CREATE TABLE custom_audit.failed_logins_$(ESCAPE_NONE(DATE))

(message_date datetime,
message_type varchar(50) NULL,
message Varchar(250) NULL);


--step2
INSERT INTO custom_audit.failed_logins_$(ESCAPE_NONE(DATE))
EXEC sp_readerrorlog 0, 1, 'Login Failed';
