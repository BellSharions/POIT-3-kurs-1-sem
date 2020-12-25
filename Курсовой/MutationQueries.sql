use Cinemas;

-----------------------------------------------------------------------------------------------------------------------------
--Sale of tickets for the seance--
go
create procedure SaleTickets @id_seance int, @id_place int
as
begin
	declare @id_ticket int;
	set @id_ticket = (select Tickets.id_ticket from PlacesSeances inner join Tickets on PlacesSeances.id_ps = Tickets.id_ticket
						  where PlacesSeances.id_seance = @id_seance and PlacesSeances.id_place = @id_place);
	update Tickets set status = '«‡ÌˇÚÓ' where id_ticket = @id_ticket;
end;

select * from Tickets
select * from PlacesSeances
exec SaleTickets @id_seance = 2, @id_place = 12;
drop procedure SaleTickets;
-------------------------------------------------------------------------------------------------------------------------------------

--Return ticket for the seance--
go
create procedure ReturnTickets @id_seance int, @id_place int
as
begin
	declare @id_ticket int;
	set @id_ticket = (select Tickets.id_ticket from PlacesSeances inner join Tickets on PlacesSeances.id_ps = Tickets.id_ticket
						  where PlacesSeances.id_seance = @id_seance and PlacesSeances.id_place = @id_place);
	update Tickets set status = '—‚Ó·Ó‰ÌÓ' where id_ticket = @id_ticket;
end;

exec ReturnTickets @id_seance = 2, @id_place = 2;
drop procedure ReturnTickets;
-------------------------------------------------------------------------------------------------------------------------------------

----------------Insert----------------------
--Tickets--
go
create procedure CreateTickets @id_ticket int, @price int, @status nvarchar(15)
as
begin
	if((select count(*) from PlacesSeances where id_ps = @id_ticket) != 0 and
		(select count(*) from Tickets where id_ticket = @id_ticket) = 0)
	begin
		insert into Tickets(id_ticket, price, status) values(@id_ticket, @price, @status);
	end;
	else print 'Incorrect id_ticket';
end;

exec CreateTickets @id_ticket = 2, @price = 1433, @status = '—‚Ó·Ó‰ÌÓ';
drop procedure CreateTickets;
----------------------------------

--Seances--
go
create procedure CreateSeances @id_film int, @date date, @time time
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0)
	begin
		insert into Seances(id_film, date, time) values(@id_film, @date, @time);
	end;
	else print 'Incorrect id_film';
end;

exec CreateSeances @id_film = 8, @date = '11.11.2021', @time = '11:20';
drop procedure CreateSeances;
----------------------------------

--RentalFilms--
go
create procedure CreateRentalFilms @id_film int, @id_cinema int, @renting_in date, @renting_out date
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0 and
		(select count(*) from Cinema where id_cinema = @id_cinema) != 0 and
		(@renting_in < @renting_out) and
		(select count(*) from RentalFilms where id_film = @id_film and id_cinema = @id_cinema) = 0)
	begin
		insert into RentalFilms(id_film, id_cinema, renting_in, renting_out) values(@id_film, @id_cinema, @renting_in, @renting_out);
	end;
	else print 'Incorrect id_film or id_cinema or renting_in > renting_out';
end;

exec CreateRentalFilms @id_film = 2, @id_cinema = 1, @renting_in = '11.11.2011', @renting_out = '11.11.2012';
drop procedure CreateRentalFilms;
----------------------------------

--Cinema--
go
create procedure CreateCinema @name_cinema nvarchar(50), @region nvarchar(30),
							@address nvarchar(50), @phone nvarchar(20), @website nvarchar(100)
as
begin
	insert into Cinema(name_cinema, region, address, phone, website) 
			values(@name_cinema, @region, @address, @phone, @website);
end;

exec GetAllCinema;
exec CreateCinema  @name_cinema = 'OLDDDD', @region = 'OLDDDD', @address = 'OLDDDD',
					@phone = 'OLDDDD', @website = 'OLDDDD';
drop procedure CreateCinema;
----------------------------------

--Films--
go
create procedure CreateFilms  @age_restrictions nvarchar(5), @name_film nvarchar(30),
							@year date, @description nvarchar(MAX), @duration int, @format nvarchar(5)
as
begin
	if((select count(*) from AgeRestrictions where age_restrictions = @age_restrictions) != 0 and
		(select count(*) from Format where format = @format) != 0)
	begin
		insert into Films(age_restrictions, name_film, year, description, duration, format)
			values(@age_restrictions, @name_film, @year, @description, @duration, @format);
	end;
	else print 'Incorrect age_restriction or format';
end;

exec CreateFilms @age_restrictions = 'G', @name_film = 'afaNEW2222', @year = '01.01.2000', 
						@description = 'NEWafaf222', @duration = 1, @format = '3D';
drop procedure CreateFilms;
----------------------------------

--FilmCompany--
go
create procedure CreateFilmCompany @id_film int, @name_Òompany nvarchar(50)
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0 and
		(select count(*) from FilmCompany where id_film = @id_film and name_Òompany = @name_Òompany) = 0)
	begin
		insert into FilmCompany(id_film, name_Òompany) values(@id_film, @name_Òompany);
	end;
	else print 'Incorrect id_film or such company is exist';
end;

exec CreateFilmCompany @id_film = 2, @name_Òompany = 'NEafafafWf';
drop procedure CreateFilmCompany;
----------------------------------

--FilmProducer--
go
create procedure CreateFilmProducer @id_film int, @name_producer nvarchar(50)
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0 and
		(select count(*) from FilmProducer where id_film = @id_film and name_producer = @name_producer) = 0)
	begin
		insert into FilmProducer(id_film, name_producer) values(@id_film, @name_producer);
	end;
	else print 'Incorrect id_film or such producer is exist';
end;

exec CreateFilmProducer @id_film = 6, @name_producer = 'NEafafaffW';
drop procedure CreateFilmProducer;
----------------------------------

--FilmGenre--
go
create procedure CreateFilmGenre @id_film int, @name_genre nvarchar(50)
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0 and
		(select count(*) from FilmGenre where id_film = @id_film and name_genre = @name_genre) = 0)
	begin
		insert into FilmGenre(id_film, name_genre) values(@id_film, @name_genre);
	end;
	else print 'Incorrect id_film or such genre is exist';
end;

exec CreateFilmGenre @id_film = 6, @name_genre = 'NEafafafW';
drop procedure CreateFilmGenre;
----------------------------------

--Hall--
go
create procedure CreateHall @id_cinema int, @name_hall nvarchar(30), @capacity int
as
begin
	if((select count(*) from Cinema where id_cinema = @id_cinema) != 0)
	begin
		insert into Hall(id_cinema, name_hall, Òapacity) values(@id_cinema, @name_hall, @capacity)
	end;
	else print 'Incorrect id_cinema';
end;

exec CreateHall  @id_cinema = 1, @name_hall = 'NEWHALLHEH', @capacity = 1222;
drop procedure CreateHall;
----------------------------------

--Places--
go
create procedure CreatePlaces @id_hall int, @type nvarchar(15), @number int, @row int
as
begin
	declare @capacity int, @countPlaces int;
	set @capacity = (select Òapacity from Hall where id_hall = @id_hall);
	set @countPlaces = (select count(*) from Places where id_hall = @id_hall);
	if((select count(*) from Hall where id_hall = @id_hall) != 0 and
		(select count(*) from TypePlaces where type = @type) != 0 and
		(@countPlaces < @capacity))
	begin
		insert into Places(id_hall, type, number, row) values(@id_hall, @type, @number, @row);
	end;
	else print 'Incorrect id_hall or type or capacity is full';
end;

exec CreatePlaces @id_hall = 11, @type = 'VIP', @number = 222, @row = 222;
drop procedure CreatePlaces;
----------------------------------

--PlacesSeances--
go
create procedure CreatePlacesSeances @id_place int, @id_seance int
as
begin
	declare @film int = (select id_film from Seances where id_seance = @id_seance);
	declare @ddate date = (select date from Seances where id_seance = @id_seance);
	declare @idFilm int, @rentIn date, @rentOut date;
	if((select count(*) from Places where id_place = @id_place) != 0 and
		(select count(*) from Seances where id_seance = @id_seance) != 0 and
		(select count(*) from PlacesSeances where id_place = @id_place and id_seance = @id_seance) = 0 and
		exists(select distinct RentalFilms.id_film, RentalFilms.renting_in, RentalFilms.renting_out from Places 
						inner join Hall on Places.id_hall = Hall.id_hall 
						inner join Cinema on Hall.id_cinema = Cinema.id_cinema 
						inner join RentalFilms on Cinema.id_cinema = RentalFilms.id_cinema 
						where Places.id_place = 18 and RentalFilms.id_film = 1) and
		((select distinct RentalFilms.renting_in from Places 
						inner join Hall on Places.id_hall = Hall.id_hall 
						inner join Cinema on Hall.id_cinema = Cinema.id_cinema 
						inner join RentalFilms on Cinema.id_cinema = RentalFilms.id_cinema 
						where Places.id_place = @id_place and RentalFilms.id_film = @film) < @ddate) and
		((select distinct RentalFilms.renting_out from Places 
						inner join Hall on Places.id_hall = Hall.id_hall 
						inner join Cinema on Hall.id_cinema = Cinema.id_cinema 
						inner join RentalFilms on Cinema.id_cinema = RentalFilms.id_cinema 
						where Places.id_place = @id_place and RentalFilms.id_film = @film) > @ddate))
	begin
		insert into PlacesSeances(id_place, id_seance) values(@id_place, @id_seance);
	end;
	else print 'Incorrect id_place or id_seance or such entry is exist or there is no rental film in cinema';
end;

exec CreatePlacesSeances @id_place = 12, @id_seance = 2;
drop procedure CreatePlacesSeances;
----------------------------------

----------------Update----------------------
--Tickets--
go
create procedure UpdateTickets @id_ticket int, @price int, @status nvarchar(15)
as
begin
	update Tickets set price = @price, status = @status where id_ticket = @id_ticket;
end;

exec UpdateTickets @id_ticket = 12, @price = 1, @status = 'NEW';
drop procedure UpdateTickets;
----------------------------------

--Seances--
go
create procedure UpdateSeances @id_seance int, @id_film int, @date date, @time time
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0)
	begin
		update Seances set id_film = @id_film, date = @date, time = @time where id_seance = @id_seance;
	end;
	else print 'Incorrect id_film';
end;

exec UpdateSeances @id_seance = 8, @id_film = 5, @date = '11.11.2011', @time = '00:00';
drop procedure UpdateSeances; 
----------------------------------

--RentalFilms--
go
create procedure UpdateRentalFilms @id_rental int, @id_film int, @id_cinema int, @renting_in date, @renting_out date
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0 and
		(select count(*) from Cinema where id_cinema = @id_cinema) != 0 and
		(@renting_in < @renting_out))
	begin
		update RentalFilms set id_film = @id_film, id_cinema = @id_cinema, renting_in = @renting_in, renting_out = @renting_out 
				where id_rental = @id_rental;
	end;
	else print 'Incorrect id_film or id_cinema or renting_in > renting_out';
end;

exec UpdateRentalFilms @id_rental = 30, @id_film = 5, @id_cinema = 1, @renting_in = '11.11.2011', @renting_out = '12.12.2012';
drop procedure UpdateRentalFilms;
----------------------------------

--Cinema--
go
create procedure UpdateCinema @id_cinema int, @name_cinema nvarchar(50), @region nvarchar(30),
							@address nvarchar(50), @phone nvarchar(20), @website nvarchar(100)
as
begin
	update Cinema set name_cinema = @name_cinema, region = @region, address = @address, 
					phone = @phone, website = @website where id_cinema = @id_cinema;
end;

exec GetAllCinema;
exec UpdateCinema @id_cinema = 1, @name_cinema = 'NEW', @region = 'NEW', @address = 'NEW',
					@phone = 'NEW', @website = 'NEW';
drop procedure UpdateCinema;
----------------------------------

--Films--
go
create procedure UpdateFilms @id_film int, @age_restrictions nvarchar(5), @name_film nvarchar(30),
							@year date, @description nvarchar(MAX), @duration int, @format nvarchar(5)
as
begin
	if((select count(*) from AgeRestrictions where age_restrictions = @age_restrictions) != 0 and
		(select count(*) from Format where format = @format) != 0)
	begin
		update Films set age_restrictions = @age_restrictions, name_film = @name_film, year = @year,
						description = @description, duration = @duration, format = @format where id_film = @id_film;
	end;
	else print 'Incorrect age_restriction or format';
end;

exec UpdateFilms @id_film = 2, @age_restrictions = 'G', @name_film = 'NEW2222', @year = '01.01.2000', 
						@description = 'NEW222', @duration = 1, @format = '4D';
drop procedure UpdateFilms;
----------------------------------

--FilmCompany--
go
create procedure UpdateFilmCompany @id_company int, @id_film int, @name_Òompany nvarchar(50)
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0)
	begin
		update FilmCompany set id_film = @id_film, name_Òompany = @name_Òompany where id_company = @id_company;
	end;
	else print 'Incorrect id_film';
end;

exec UpdateFilmCompany @id_company = 4, @id_film = 5, @name_Òompany = 'NEW';
drop procedure UpdateFilmCompany;
----------------------------------

--FilmProducer--
go
create procedure UpdateFilmProducer @id_producer int, @id_film int, @name_producer nvarchar(50)
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0)
	begin
		update FilmProducer set id_film = @id_film, name_producer = @name_producer where id_producer = @id_producer;
	end;
	else print 'Incorrect id_film';
end;

exec UpdateFilmProducer @id_producer = 2, @id_film = 2, @name_producer = 'NEW';
drop procedure UpdateFilmProducer;
----------------------------------

--FilmGenre--
go
create procedure UpdateFilmGenre @id_genre int, @id_film int, @name_genre nvarchar(50)
as
begin
	if((select count(*) from Films where id_film = @id_film) != 0)
	begin
		update FilmGenre set id_film = @id_film, name_genre = @name_genre where id_genre = @id_genre;
	end;
	else print 'Incorrect id_film';
end;

exec UpdateFilmGenre @id_genre = 4, @id_film = 4, @name_genre = 'NEWGANRE';
drop procedure UpdateFilmGenre;
----------------------------------

--Hall--
go
create procedure UpdateHall @id_hall int, @id_cinema int, @name_hall nvarchar(30), @capacity int
as
begin
	if((select count(*) from Cinema where id_cinema = @id_cinema) != 0)
	begin
		update Hall set id_cinema = @id_cinema, name_hall = @name_hall, Òapacity = @capacity
						where id_hall = @id_hall;
	end;
	else print 'Incorrect id_cinema';
end;

exec UpdateHall @id_hall = 2, @id_cinema = 1, @name_hall = 'HALL', @capacity = 1;
drop procedure UpdateHall;
----------------------------------

--Places--
go
create procedure UpdatePlaces @id_place int, @id_hall int, @type nvarchar(15), @number int, @row int
as
begin
	if((select count(*) from Hall where id_hall = @id_hall) != 0 and
		(select count(*) from TypePlaces where type = @type) != 0)
	begin
		update Places set id_hall = @id_hall, type = @type, number = @number, row = @row
						where id_place = @id_place;
	end;
	else print 'Incorrect id_hall or type';
end;

exec UpdatePlaces @id_place = 3, @id_hall = 4, @type = 'VIP', @number = 111, @row = 111;
drop procedure UpdatePlaces;
----------------------------------

--PlacesSeances--
go
create procedure UpdatePlacesSeances @id_ps int, @id_place int, @id_seance int
as
begin
	if((select count(*) from Places where id_place = @id_place) != 0 and
		(select count(*) from Seances where id_seance = @id_seance) != 0)
	begin
		update PlacesSeances set id_place = @id_place, id_seance = @id_seance
								where id_ps = @id_ps;
	end;
	else print 'Incorrect id_place or id_seance';
end;

exec UpdatePlacesSeances @id_ps = 11, @id_place = 3, @id_seance = 6;
drop procedure UpdatePlacesSeances;
----------------------------------

----------------Delete----------------------

--Seances--
go
create procedure DeleteEndSeances
as
begin
	delete from Seances where date < getdate();
end;

exec DeleteEndSeances;
drop procedure DeleteEndSeances;
----------------------------------


--RentalFilms--
go
create procedure DeleteEndRentalFilms
as
begin
	delete from RentalFilms where renting_out < getdate();
end;

exec DeleteEndRentalFilms;
drop procedure DeleteEndRentalFilms;
----------------------------------