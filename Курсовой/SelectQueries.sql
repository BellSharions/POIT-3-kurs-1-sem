use Cinemas;

-----------------------------------------------------------------------------------------------------------------------------
--Getting a cinema by the name--
go
create procedure GetCinemaByName @name nvarchar(50)
as
begin
	select * from Cinema where name_cinema = @name;
end;

exec GetCinemaByName @name = 'Октябрь';
drop procedure GetCinemaByName;

--Getting a list of cinemas in a specified address--
go
create procedure GetCinemaByAddress @address nvarchar(50)
as
begin
	select * from Cinema where address = @address;
end;

exec GetCinemaByAddress @address = 'Проспект Независимости 73';
drop procedure GetCinemaByAddress;


--Getting a list of cinemas in a specified region--
go
create procedure GetCinemaByRegion @region nvarchar(50)
as
begin
	select * from Cinema where region = @region;
end;

exec GetCinemaByRegion @region = 'Минск';
drop procedure GetCinemaByRegion;


--Getting a list of seances for a specified date--
go
create procedure GetSeancesByDate @date date
as
begin
	select * from Seances where date = @date;
end;

exec GetSeancesByDate @date = '18.12.2020';
drop procedure GetSeancesByDate;


--Getting a list of seances by film name--
go
create procedure GetSeancesByFilmName @name_film nvarchar(30)
as
begin
	declare @id_film int;
	set @id_film = (select id_film from Films where name_film = @name_film);
	select * from Seances where id_film = @id_film;
end;

exec GetSeancesByFilmName @name_film = 'Царство';
drop procedure GetSeancesByFilmName;


--Getting a list of films that are in the rental--
go
create procedure GetRentalFilmsInCinema @name_cinema nvarchar(50)
as
begin
	declare @id_cinema int;
	set @id_cinema = (select id_cinema from Cinema where name_cinema = @name_cinema);
	select Films.id_film, Films.age_restrictions, Films.name_film, 
		   Films.year, Films.description, Films.duration, Films.format 
	from Films inner join RentalFilms on Films.id_film = RentalFilms.id_film 
	where RentalFilms.id_cinema = @id_cinema and RentalFilms.renting_out > getdate() and RentalFilms.renting_in < getDate();
end;

exec GetRentalFilmsInCinema @name_cinema = 'Октябрь';
drop procedure GetRentalFilmsInCinema;


--Getting a list of free seats for the specified seance--
go
create procedure GetFreeSeatsOnSeances @id_seance int
as
begin
	select DISTINCT Places.id_hall, Places.id_place, Places.number, Places.row, Places.type 
			 from Seances inner join PlacesSeances on Seances.id_seance = PlacesSeances.id_seance
						  inner join Tickets on PlacesSeances.id_ps = Tickets.id_ticket
						  inner join Places on PlacesSeances.id_place = Places.id_place 
						  where Seances.id_seance = @id_seance and Tickets.status = 'Свободно';
end;

exec GetFreeSeatsOnSeances @id_seance = 2;
drop procedure GetFreeSeatsOnSeances;
----------------------------------

--Getting all seances in cinema--
go
create procedure GetSeancesInCinema @id_cinema int
as
begin
	--select Seances.id_seance, Seances.id_film, Seances.date, Seances.time from Cinema inner join RentalFilms on Cinema.id_cinema = RentalFilms.id_cinema
						 --inner join Films on RentalFilms.id_film = Films.id_film
						 --inner join Seances on Films.id_film = Seances.id_film where Cinema.id_cinema = @id_cinema;
	select distinct top(1) Seances.id_seance, Seances.id_film, Seances.date, Seances.time from Cinema inner join Hall on Cinema.id_cinema = Hall.id_cinema
						inner join Places on Hall.id_hall = Places.id_hall 
						inner join PlacesSeances on Places.id_place = PlacesSeances.id_place
						inner join Seances on PlacesSeances.id_seance = Seances.id_seance
						inner join Films on Seances.id_film = Films.id_film
						inner join RentalFilms on Films.id_film = RentalFilms.id_film where Cinema.id_cinema = @id_cinema;
end;

exec GetSeancesInCinema @id_cinema = 1;
drop procedure GetSeancesInCinema;
----------------------------------

--Getting a film by name--
go
create procedure GetFilmsByName @name_film nvarchar(30)
as
begin
	select * from Films where name_film = @name_film;
end;

exec GetFilmsByName @name_film = 'Царство';
drop procedure GetFilmsByName;
----------------------------------

--Getting all cinemas--
go
create procedure GetAllCinema
as
begin
	select * from Cinema;
end;

exec GetAllCinema;
drop procedure GetAllCinema;
----------------------------------