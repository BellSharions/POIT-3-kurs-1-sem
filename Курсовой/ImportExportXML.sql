use Cinemas;

--Export xml--
go
create procedure ExportXMLCinema
as
begin
	select * from Cinema
		for xml path('cinema'), root('cinemas');

	exec master.dbo.sp_configure 'show advanced options', 1
		reconfigure with override;
	exec master.dbo.sp_configure 'xp_cmdshell', 1
		reconfigure with override;

	declare @fileName nvarchar(100)
	declare @sqlStr varchar(1000)
	declare @sqlCmd varchar(1000)

	set @fileName = 'D:\Labs\Курсовой\ExportCinema.xml';
	set @sqlStr = 'use Cinemas; select * from Cinema for xml path(''cinema''), root(''cinemas'') ';
	set @sqlCmd = 'bcp "' + @sqlStr + '" queryout ' + @fileName + ' -w -T';
	exec xp_cmdshell @sqlCmd;
end;

exec ExportXMLCinema;
drop procedure ExportXMLCinema;


--Import xml--
go
create procedure ImportXMLCinema
as
begin
	insert into Cinema (name_cinema, region, address, phone, website)
	select
	   MY_XML.Cinema.query('name_cinema').value('.', 'nvarchar(50)'),
	   MY_XML.Cinema.query('region').value('.', 'nvarchar(30)'),
	   MY_XML.Cinema.query('address').value('.', 'nvarchar(50)'),
	   MY_XML.Cinema.query('phone').value('.', 'nvarchar(20)'),
	   MY_XML.Cinema.query('website').value('.', 'nvarchar(100)')
	from (select cast(MY_XML as xml)
		  from openrowset(bulk 'D:\Labs\Курсовой\ImportCinema.xml', single_blob) as T(MY_XML)) as T(MY_XML)
		  cross apply MY_XML.nodes('cinemas/cinema') as MY_XML (Cinema);
end;

exec GetAllCinema;
exec ImportXMLCinema;
drop procedure ImportXMLCinema;