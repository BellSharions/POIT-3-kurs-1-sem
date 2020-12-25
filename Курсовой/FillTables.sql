use Cinemas;

insert into AgeRestrictions(age_restrictions) values
	('G'), ('PG'), ('PG-13'), ('R'), ('NC-17');

insert into TypePlaces(type) values
	('VIP'), ('������');

insert into Format(format) values
	('2D'), ('3D'), ('4D');


--Cinema
exec CreateCinema @name_cinema = '�������', @region = '�����', @address = '�������� ������������� 73', @phone = '8 017 292-93-25', @website = 'www.october.by';
exec CreateCinema @name_cinema = '������������', @region = '�����', @address = '�������� ������������ 104', @phone = '8 017 336-99-64', @website = 'www.artCinema.by';
exec CreateCinema @name_cinema = '����� ������', @region = '���������', @address = '��. ������ 45', @phone = '8 029 547-33-27', @website = 'www.zorkav-venera.by';

--Films
exec CreateFilms @age_restrictions = 'G', @name_film = '������� �������������� ����', @year = '01.01.2020', 
				@description = '�� �� � ��������, ������� � �����, ������� ��������� ������������ �����, 
								����� ������� ������� � ���� �����. � ��� ��� ������� ���� �� ��� � ������, ������� ����� ���������.
								������ �� ��� ������� �������� �������������� ��� ��� ���-�. 
								��� ����� �������� �� ������������� �����, ����� ������� ��� ��� ������ �� ��������.', @duration = 70, @format = '2D';
exec CreateFilms @age_restrictions = 'NC-17', @name_film = '�� ���� ��������', @year = '13.11.2020', 
				@description = '������� ���� ����� ����� ��-�� ����������� ������ �����. 
								�������� �� ��������, ��� ������ ���������� � ������������� �������: 
								������� �������� ���������� �������, ����� ��������� ��� ��� ����������� ������ � ������� ���� � �����, 
								�������� ��� ���� � ��� ����������� ������. 
								�� ��������� � ���������� ��� ���������� �� �����������, 
								�� ��� �������� ��������� ����������� ����, ����� ������� ���� � ������ ����������.', @duration = 97, @format = '2D';
exec CreateFilms @age_restrictions = 'PG', @name_film = '�������', @year = '03.04.2013', 
				@description = '1557 ���. �������� ��������� ����� � ������� ������� � ���������. 
								�������� ����� ������������ � ��� � ����� �� ������ ���������, �� � ����� ������ ���������. 
								��� ������� �� �������� ������ ��� �� ������ ���������� � ������ ������� � �������� ���� ������, 
								� ������� ������� � �������� ���������� ������ ���� �����, 
								������� ����� �� ����������� � ��������� �������, ������ � ������.', @duration = 43, @format = '3D';
exec CreateFilms @age_restrictions = 'PG-13', @name_film = '������ � ���������: ����� �� ������ �����', @year = '11.12.2020', 
				@description = '� ��������, �������, �� ������� �� ������� ������� � � ������ ���������� � ���������� ������������, 
								������� ��� ������� �� �����.', @duration = 97, @format = '4D';
exec CreateFilms @age_restrictions = 'R', @name_film = '����������', @year = '28.08.2019', 
				@description = '� ����� ����������������� �������� ���� ����� ������ �������. 
								������������� ������� ���� ������ �� ���. ��� ������� � ����� ����� ���������. 
								������ ������� �� ��������� ������� ������� �� ������ ��������, ������ �� ��������� ������� ����������. 
								��������� �������� ������� ��������, �� ���� ���� �� �������, ���� ������� ���� ������� ������� �������. 
								������ � ���������� ������ ��������� �� ���������. ��� ������ ���� � �������. 
								����������� ������������� ����� �� ��������. 
								���������� ����� �������������� � ������� �������, ����� �� ������ ������������ � �������, 
								������� ��������� �������� �� ����������� ������.', @duration = 40, @format = '3D';

--FilmGenre
exec CreateFilmGenre @id_film = 1, @name_genre = '�������';
exec CreateFilmGenre @id_film = 1, @name_genre = '���������';
exec CreateFilmGenre @id_film = 2, @name_genre = '�����';
exec CreateFilmGenre @id_film = 3, @name_genre = '�������';
exec CreateFilmGenre @id_film = 3, @name_genre = '�����';
exec CreateFilmGenre @id_film = 4, @name_genre = '��������������';
exec CreateFilmGenre @id_film = 5, @name_genre = '����������';
exec CreateFilmGenre @id_film = 5, @name_genre = '������';
exec CreateFilmGenre @id_film = 5, @name_genre = '�����������';

--FilmProducer
exec CreateFilmProducer @id_film = 1, @name_producer = '��� ���-��';
exec CreateFilmProducer @id_film = 2, @name_producer = '������� ��. ���';
exec CreateFilmProducer @id_film = 3, @name_producer = '���� ������';
exec CreateFilmProducer @id_film = 3, @name_producer = '����� ����';
exec CreateFilmProducer @id_film = 3, @name_producer = '����� �����';
exec CreateFilmProducer @id_film = 4, @name_producer = '������ ������';
exec CreateFilmProducer @id_film = 4, @name_producer = '���� �����������';
exec CreateFilmProducer @id_film = 5, @name_producer = '������ ���';
exec CreateFilmProducer @id_film = 5, @name_producer = '��� ��������';
exec CreateFilmProducer @id_film = 5, @name_producer = '���� ������';

--FilmCompany
exec CreateFilmCompany @id_film = 1, @name_�ompany = 'Studio Dragon';
exec CreateFilmCompany @id_film = 2, @name_�ompany = 'Satanist';
exec CreateFilmCompany @id_film = 3, @name_�ompany = 'Universal pictures';
exec CreateFilmCompany @id_film = 4, @name_�ompany = 'Warner bros. entertainment';
exec CreateFilmCompany @id_film = 5, @name_�ompany = 'Sony pictures entertainment';

--RentalFilms
exec CreateRentalFilms @id_film = 1, @id_cinema = 1, @renting_in = '04.12.2020', @renting_out = '13.02.2021';
exec CreateRentalFilms @id_film = 3, @id_cinema = 1, @renting_in = '21.10.2020', @renting_out = '13.11.2020';
exec CreateRentalFilms @id_film = 5, @id_cinema = 2, @renting_in = '11.06.2020', @renting_out = '02.08.2020';
exec CreateRentalFilms @id_film = 2, @id_cinema = 2, @renting_in = '15.12.2020', @renting_out = '22.01.2021';
exec CreateRentalFilms @id_film = 1, @id_cinema = 3, @renting_in = '16.03.2020', @renting_out = '22.05.2020';
exec CreateRentalFilms @id_film = 3, @id_cinema = 3, @renting_in = '02.08.2020', @renting_out = '14.10.2020';

--Hall
exec CreateHall @id_cinema = 1, @name_hall = '����� ���', @capacity = 30;
exec CreateHall @id_cinema = 1, @name_hall = '������� ���', @capacity = 60;
exec CreateHall @id_cinema = 2, @name_hall = '����� ���', @capacity = 23;
exec CreateHall @id_cinema = 2, @name_hall = '������� ���', @capacity = 46;
exec CreateHall @id_cinema = 3, @name_hall = '����� ���', @capacity = 11;
exec CreateHall @id_cinema = 3, @name_hall = '������� ���', @capacity = 22;

--Places
exec CreatePlaces @id_hall = 1, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 1, @type = '������', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 1, @type = 'VIP', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 2, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 2, @type = '������', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 2, @type = '������', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 3, @type = '������', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 3, @type = 'VIP', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 3, @type = '������', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 4, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 4, @type = 'VIP', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 4, @type = 'VIP', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 5, @type = '������', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 5, @type = '������', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 5, @type = '������', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 6, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 6, @type = 'VIP', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 6, @type = '������', @number = 3, @row = 1;

--Seances
exec CreateSeances @id_film = 1, @date = '10.12.2020', @time = '11:00';
exec CreateSeances @id_film = 2, @date = '18.12.2020', @time = '15:30';
exec CreateSeances @id_film = 3, @date = '05.12.2020', @time = '23:00';
exec CreateSeances @id_film = 4, @date = '21.12.2020', @time = '18:00';
exec CreateSeances @id_film = 5, @date = '27.12.2020', @time = '12:00';


--PlacesSeances
exec CreatePlacesSeances @id_place = 1, @id_seance = 1;
exec CreatePlacesSeances @id_place = 2, @id_seance = 1;
exec CreatePlacesSeances @id_place = 3, @id_seance = 1;
exec CreatePlacesSeances @id_place = 10, @id_seance = 2;
exec CreatePlacesSeances @id_place = 11, @id_seance = 2;
exec CreatePlacesSeances @id_place = 12, @id_seance = 2;


--Tickets
exec CreateTickets @id_ticket = 1, @price = 1313, @status = '��������';
exec CreateTickets @id_ticket = 2, @price = 255, @status = '��������';
exec CreateTickets @id_ticket = 3, @price = 475, @status = '��������';
exec CreateTickets @id_ticket = 4, @price = 1315, @status = '��������';
exec CreateTickets @id_ticket = 5, @price = 1935, @status = '��������';
exec CreateTickets @id_ticket = 6, @price = 1133, @status = '��������';

delete from PlacesSeances;
dbcc checkident('PlacesSeances', reseed, 0);