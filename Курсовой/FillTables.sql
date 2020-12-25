use Cinemas;

insert into AgeRestrictions(age_restrictions) values
	('G'), ('PG'), ('PG-13'), ('R'), ('NC-17');

insert into TypePlaces(type) values
	('VIP'), ('Эконом');

insert into Format(format) values
	('2D'), ('3D'), ('4D');


--Cinema
exec CreateCinema @name_cinema = 'Октябрь', @region = 'Минск', @address = 'Проспект Независимости 73', @phone = '8 017 292-93-25', @website = 'www.october.by';
exec CreateCinema @name_cinema = 'АртКинотеатр', @region = 'Минск', @address = 'Проспект Дзержинского 104', @phone = '8 017 336-99-64', @website = 'www.artCinema.by';
exec CreateCinema @name_cinema = 'Зорка Венера', @region = 'Солигорск', @address = 'Ул. Ленина 45', @phone = '8 029 547-33-27', @website = 'www.zorkav-venera.by';

--Films
exec CreateFilms @age_restrictions = 'G', @name_film = 'История девятихвостого лиса', @year = '01.01.2020', 
				@description = 'Ли Ён — божество, живущее в горах, которое принимает человеческий облик, 
								чтобы навести порядок в мире людей. А вот его сводный брат Ли Ран — кумихо, который людей ненавидит.
								Именно на них выходит продюсер экстремального шоу Нам Джи-а. 
								Она давно охотится за девятихвостым лисом, чтобы заснять его для одного из выпусков.', @duration = 70, @format = '2D';
exec CreateFilms @age_restrictions = 'NC-17', @name_film = 'Всё ради Джексона', @year = '13.11.2020', 
				@description = 'Пожилая пара убита горем из-за трагической гибели внука. 
								Обезумев от отчаяния, они решают прибегнуть к экстремальным методам: 
								старики похищают беременную женщину, чтобы совершить над ней сатанинский ритуал и вернуть чадо к жизни, 
								поместив его душу в ещё нерождённого ребёнка. 
								Но поскольку в колдовстве они совершенно не разбираются, 
								их дом начинают заполнять беспокойные духи, среди которых есть и крайне зловредные.', @duration = 97, @format = '2D';
exec CreateFilms @age_restrictions = 'PG', @name_film = 'Царство', @year = '03.04.2013', 
				@description = '1557 год. Королеву Шотландии Марию с детства держали в монастыре. 
								Приходит время возвращаться в мир и стать не только королевой, но и женой принца Франциска. 
								Тот смотрит на женитьбу только как на способ сблизиться с другой страной и укрепить свою власть, 
								а светлые чувства и влечения испытывает только сама Мария, 
								которая сразу же оказывается в эпицентре сплетен, слухов и интриг.', @duration = 43, @format = '3D';
exec CreateFilms @age_restrictions = 'PG-13', @name_film = 'Кометы и метеориты: Гости из далёких миров', @year = '11.12.2020', 
				@description = 'О метеорах, кометах, их влиянии на древние религии и о прочих культурных и физических воздействиях, 
								которые они оказали на Землю.', @duration = 97, @format = '4D';
exec CreateFilms @age_restrictions = 'R', @name_film = 'Мандалорец', @year = '28.08.2019', 
				@description = 'В жизни профессионального наемника было много разных событий. 
								Представитель древней расы отошел от дел. Его занесло в самую глушь Галактики. 
								Теперь мужчину не беспокоят военные баталии на других планетах, откуда не поступает никакая информация. 
								Персонажа окружают отбросы общества, но этот факт не смущает, ведь опытный воин отлично наводит порядок. 
								Законы в отдаленном уголке Вселенной не действуют. Все решает сила и влияние. 
								Бесстрашных соплеменников почти не осталось. 
								Мандалорец живет воспоминаниями о славном времени, когда он быстро расправлялся с врагами, 
								получал приличные гонорары за выполненную работу.', @duration = 40, @format = '3D';

--FilmGenre
exec CreateFilmGenre @id_film = 1, @name_genre = 'Фэнтези';
exec CreateFilmGenre @id_film = 1, @name_genre = 'Мелодрама';
exec CreateFilmGenre @id_film = 2, @name_genre = 'Ужасы';
exec CreateFilmGenre @id_film = 3, @name_genre = 'Фэнтези';
exec CreateFilmGenre @id_film = 3, @name_genre = 'Драма';
exec CreateFilmGenre @id_film = 4, @name_genre = 'Документальный';
exec CreateFilmGenre @id_film = 5, @name_genre = 'Фантастика';
exec CreateFilmGenre @id_film = 5, @name_genre = 'Боевик';
exec CreateFilmGenre @id_film = 5, @name_genre = 'Приключения';

--FilmProducer
exec CreateFilmProducer @id_film = 1, @name_producer = 'Кан Щин-хё';
exec CreateFilmProducer @id_film = 2, @name_producer = 'Джастин Дж. Дик';
exec CreateFilmProducer @id_film = 3, @name_producer = 'Фред Гербер';
exec CreateFilmProducer @id_film = 3, @name_producer = 'Холли Дэйл';
exec CreateFilmProducer @id_film = 3, @name_producer = 'Норма Бэйли';
exec CreateFilmProducer @id_film = 4, @name_producer = 'Вернер Херцог';
exec CreateFilmProducer @id_film = 4, @name_producer = 'Клив Оппенхаймер';
exec CreateFilmProducer @id_film = 5, @name_producer = 'Дебора Чоу';
exec CreateFilmProducer @id_film = 5, @name_producer = 'Рик Фамуйива';
exec CreateFilmProducer @id_film = 5, @name_producer = 'Дэйв Филони';

--FilmCompany
exec CreateFilmCompany @id_film = 1, @name_сompany = 'Studio Dragon';
exec CreateFilmCompany @id_film = 2, @name_сompany = 'Satanist';
exec CreateFilmCompany @id_film = 3, @name_сompany = 'Universal pictures';
exec CreateFilmCompany @id_film = 4, @name_сompany = 'Warner bros. entertainment';
exec CreateFilmCompany @id_film = 5, @name_сompany = 'Sony pictures entertainment';

--RentalFilms
exec CreateRentalFilms @id_film = 1, @id_cinema = 1, @renting_in = '04.12.2020', @renting_out = '13.02.2021';
exec CreateRentalFilms @id_film = 3, @id_cinema = 1, @renting_in = '21.10.2020', @renting_out = '13.11.2020';
exec CreateRentalFilms @id_film = 5, @id_cinema = 2, @renting_in = '11.06.2020', @renting_out = '02.08.2020';
exec CreateRentalFilms @id_film = 2, @id_cinema = 2, @renting_in = '15.12.2020', @renting_out = '22.01.2021';
exec CreateRentalFilms @id_film = 1, @id_cinema = 3, @renting_in = '16.03.2020', @renting_out = '22.05.2020';
exec CreateRentalFilms @id_film = 3, @id_cinema = 3, @renting_in = '02.08.2020', @renting_out = '14.10.2020';

--Hall
exec CreateHall @id_cinema = 1, @name_hall = 'Малый зал', @capacity = 30;
exec CreateHall @id_cinema = 1, @name_hall = 'Большой зал', @capacity = 60;
exec CreateHall @id_cinema = 2, @name_hall = 'Малый зал', @capacity = 23;
exec CreateHall @id_cinema = 2, @name_hall = 'Большой зал', @capacity = 46;
exec CreateHall @id_cinema = 3, @name_hall = 'Малый зал', @capacity = 11;
exec CreateHall @id_cinema = 3, @name_hall = 'Большой зал', @capacity = 22;

--Places
exec CreatePlaces @id_hall = 1, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 1, @type = 'Эконом', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 1, @type = 'VIP', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 2, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 2, @type = 'Эконом', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 2, @type = 'Эконом', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 3, @type = 'Эконом', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 3, @type = 'VIP', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 3, @type = 'Эконом', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 4, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 4, @type = 'VIP', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 4, @type = 'VIP', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 5, @type = 'Эконом', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 5, @type = 'Эконом', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 5, @type = 'Эконом', @number = 3, @row = 1;
exec CreatePlaces @id_hall = 6, @type = 'VIP', @number = 1, @row = 1;
exec CreatePlaces @id_hall = 6, @type = 'VIP', @number = 2, @row = 1;
exec CreatePlaces @id_hall = 6, @type = 'Эконом', @number = 3, @row = 1;

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
exec CreateTickets @id_ticket = 1, @price = 1313, @status = 'Свободно';
exec CreateTickets @id_ticket = 2, @price = 255, @status = 'Свободно';
exec CreateTickets @id_ticket = 3, @price = 475, @status = 'Свободно';
exec CreateTickets @id_ticket = 4, @price = 1315, @status = 'Свободно';
exec CreateTickets @id_ticket = 5, @price = 1935, @status = 'Свободно';
exec CreateTickets @id_ticket = 6, @price = 1133, @status = 'Свободно';

delete from PlacesSeances;
dbcc checkident('PlacesSeances', reseed, 0);