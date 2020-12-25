use Cinemas;

----CREATE ADMINISTRATOR----
CREATE LOGIN ADMINISTRATOR_LOG
    WITH PASSWORD = N'admin',
	DEFAULT_DATABASE = [Cinemas]
GO

ALTER SERVER ROLE [sysadmin] ADD MEMBER [ADMINISTRATOR_LOG];
GO
	
CREATE USER ADMINISTRATOR
    FOR LOGIN ADMINISTRATOR_LOG
	WITH DEFAULT_SCHEMA = [dbo];
GO

ALTER ROLE [db_owner] ADD MEMBER [ADMINISTRATOR];
GO
----------------------------

----CREATE USER----
CREATE LOGIN CLIENT_LOG
    WITH PASSWORD = '12345',
	DEFAULT_DATABASE = [Cinemas];
GO

CREATE USER CLIENT
    FOR LOGIN CLIENT_LOG
	WITH DEFAULT_SCHEMA = [dbo];
GO

ALTER ROLE [db_datareader] ADD MEMBER [CLIENT];
ALTER ROLE [db_datawriter] ADD MEMBER [CLIENT];
GO
----------------------------

----Encryption----
use master;

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '12345';

BACKUP MASTER KEY TO FILE = 'D:\Labs\Курсовой\masterkey.mk' 
    ENCRYPTION BY PASSWORD = '12345';
GO

CREATE CERTIFICATE DBCert WITH SUBJECT = 'CertCinema';

BACKUP CERTIFICATE DBCert TO FILE = 'D:\Labs\Курсовой\rev.cer'
   WITH PRIVATE KEY (
         FILE = 'D:\Labs\Курсовой\rev.pvk',
         ENCRYPTION BY PASSWORD = '12345');
GO

USE Cinemas;

--WITH ALGORITHM = { AES_128 | AES_192 | AES_256 | TRIPLE_DES_3KEY }
CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE DBcert;

ALTER DATABASE Cinemas SET ENCRYPTION ON;

USE master;
SELECT db.[name]
, db.[is_encrypted]
, dm.[encryption_state]
, dm.[percent_complete]
, dm.[key_algorithm]
, dm.[key_length]
FROM [sys].[databases] db
LEFT OUTER JOIN [sys].[dm_database_encryption_keys] dm
ON db.[database_id] = dm.[database_id];
GO

SELECT 
NAME AS DatabaseName
,IS_ENCRYPTED AS IsEncrypted 
FROM sys.databases where name ='Cinemas'
GO
----------------------------