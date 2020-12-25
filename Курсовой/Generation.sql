use Cinemas;

--Gen random symbols
go
CREATE VIEW vRand(V) AS SELECT RAND();

go
select * from vRand;

go
create function RandomString(
@min_length int,
@max_length int,
@CharPool varchar(100)
)
returns varchar(max)
AS
BEGIN
declare @Length int, @PoolLength int, @LoopCount int, @RandomString varchar(max)
SET @Length = (select V from vRand) * (@max_length - @min_length + 1) + @min_length;

SET @PoolLength = Len(@CharPool)

SET @LoopCount = 0
SET @RandomString = ''

WHILE (@LoopCount < @Length) BEGIN
SELECT @RandomString = @RandomString +
SUBSTRING(@Charpool, CONVERT(int, (select V from vRand) * @PoolLength), 1)
SELECT @LoopCount = @LoopCount + 1
END

RETURN @RandomString;
END;
----------------------------------

--AutoInsert 100000 rows in table Cinema
go
create procedure InsertCinema
as
begin
	declare @number int, 
			@name_cinema nvarchar(50),
			@region nvarchar(30),
			@address nvarchar(50), 
			@phone nvarchar(20),
			@website nvarchar(100);
	set @number = 1;
	while @number <= 100000
	begin
		set @name_cinema = dbo.RandomString(3, 10, 'qwertyuiopasdfghjklzxcvbnméöóêåíãøùôûâàïðîëÿ÷ñìèòüá');
		set @region = dbo.RandomString(3, 10, 'qwertyuiopasdfghjklzxcvbnméöóêåíãøùôûâàïðîëÿ÷ñìèòüá');
		set @address = dbo.RandomString(3, 10, 'qwertyuiopasdfghjklzxcvbnméöóêåíãøùôûâàïðîëÿ÷ñìèòüá');
		set @phone = dbo.RandomString(3, 10, 'qwertyuiopasdfghjklzxcvbnméöóêåíãøùôûâàïðîëÿ÷ñìèòüá');
		set @website = dbo.RandomString(3, 10, 'qwertyuiopasdfghjklzxcvbnméöóêåíãøùôûâàïðîëÿ÷ñìèòüá');
		insert into Cinema values(@name_cinema, @region, @address, @phone, @website);
		set @number = @number + 1;
	end;
end;

exec InsertCinema;
exec GetAllCinema;

drop procedure InsertCinema;
delete from Cinema;
dbcc checkident('Cinema', reseed, 0);

-------------------------------------------------------------------------------------------------------------------------


--AutoInsert 100000 rows in table RentalFilms--
go
create procedure InsertRentalFilms
as
begin
	declare @number int,
			@id_film int,
			@id_cinema int,
			@renting_in date,
			@renting_out date;
	set @number = 1;
	while @number <= 100000
	begin	
		set @id_film = (select top 1 id_film from Films order by NEWID());
		set @id_cinema = (select top 1 id_cinema from Cinema order by NEWID());
		set @renting_in = '11.11.2018';
		set @renting_out = '12.11.2019';
		insert into RentalFilms values(@id_film, @id_cinema, @renting_in, @renting_out);
		set @number = @number + 1;
	end;
end;

exec InsertRentalFilms;
exec GetAllRentalFilms;

drop procedure InsertRentalFilms;
delete from RentalFilms;
dbcc checkident('RentalFilms', reseed, 0);
-------------------------------------------------------------------------------------------------------------------------




