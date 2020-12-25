drop table Tickets;
drop table PlacesSeances;
drop table Seances;
drop table Places;
drop table TypePlaces;
drop table Hall;
drop table FilmCompany;
drop table FilmGenre;
drop table FilmProducer;
drop table RentalFilms;
drop table Films;
drop table AgeRestrictions;
drop table Cinema;
drop table Format;

create table Cinema
(	
	id_cinema int identity(1,1) primary key,
	name_cinema nvarchar(50) not null,
	region nvarchar(30) not null,
	address nvarchar(50) not null,
	phone nvarchar(20) not null,
	website nvarchar(100) not null
);

create table AgeRestrictions
(
	age_restrictions nvarchar(5) primary key
);

create table Format(
	format nvarchar(5) primary key
);

create table Films
(
	id_film int identity(1,1) primary key,
	age_restrictions nvarchar(5) constraint Films_AgeRestrictions_FK foreign key references AgeRestrictions(age_restrictions) on delete cascade not null,
	name_film nvarchar(30) not null,
	year date not null,
	description nvarchar(MAX) not null,
	duration int not null,
	format nvarchar(5) constraint Films_Format_FK foreign key references Format(format) on delete cascade not null
);

create table FilmCompany
(
	id_company int identity(1,1) primary key,
	id_film int constraint FileCompany_Films_FK foreign key references Films(id_film) on delete cascade not null,
	name_ñompany nvarchar(50) not null
);

create table FilmProducer
(
	id_producer int identity(1,1) primary key,
	id_film int constraint FileProducer_Films_FK foreign key references Films(id_film) on delete cascade not null,
	name_producer nvarchar(50) not null
);

create table FilmGenre
(
	id_genre int identity(1,1) primary key,
	id_film int constraint FileGenre_Films_FK foreign key references Films(id_film) on delete cascade not null,
	name_genre nvarchar(50) not null
);

create table RentalFilms
(
	id_rental int identity(1,1) primary key,
	id_film int constraint RentalFilms_Films_FK foreign key references Films(id_film) on delete cascade not null,
	id_cinema int constraint RentalFilms_Cinema_FK foreign key references Cinema(id_cinema) on delete cascade not null,
	renting_in date not null,
	renting_out date not null
);

create table Hall
(
	id_hall int identity(1,1) primary key,
	id_cinema int constraint Hall_Cinema_FK foreign key references Cinema(id_cinema) on delete cascade not null,
	name_hall nvarchar(30) not null,
	ñapacity int not null
);

create table TypePlaces
(
	type nvarchar(15) primary key
);

create table Places
(
	id_place int identity(1,1) primary key,
	id_hall int constraint Places_Hall_FK foreign key references Hall(id_hall) on delete cascade not null,
	type nvarchar(15) constraint Places_TypePlaces_FK foreign key references TypePlaces(type) on delete cascade not null,
	number int not null,
	row int not null
);

create table Seances
(
	id_seance int identity(1,1) primary key,
	id_film int constraint Seances_Films_FK foreign key references Films(id_film) on delete cascade not null,
	date date not null,
	time time not null
);

create table PlacesSeances
(
	id_ps int identity(1,1) primary key,
	id_place int constraint PlacesSeances_Places_FK foreign key references Places(id_place) on delete cascade,
	id_seance int constraint PlacesSeances_Seances_FK foreign key references Seances(id_seance) on delete cascade,
);

create table Tickets
(
	id_ticket int primary key constraint Tickets_PlacesSeances_FK foreign key references PlacesSeances(id_ps) on delete cascade,
	price int not null,
	status nvarchar(15) not null
);
