use Cinemas;

--Films
create unique nonclustered index index_Films_id on Films(id_film);
create nonclustered index index_Films_name on Films(name_film);

--FilmCompany
create unique nonclustered index index_FilmCompany_idf_nc on FilmCompany(id_film, name_ñompany);

--FilmProducer
create unique nonclustered index index_FilmProducer_idf_np on FilmProducer(id_film, name_producer);

--FilmGenre
create unique nonclustered index index_FilmGenre_idf_ng on FilmGenre(id_film, name_genre);

--Cinema
create unique nonclustered index index_Cinema_id on Cinema(id_cinema);
create nonclustered index index_Cinema_name on Cinema(name_cinema);
create nonclustered index index_Cinema_region on Cinema(region);
create nonclustered index index_Cinema_address on Cinema(address);

--Hall
create unique nonclustered index index_Hall_id on Hall(id_hall);

--RentalFilms 
create unique nonclustered index index_RentalFilms_id on RentalFilms(id_rental);
create nonclustered index index_RentalFilms_in_out on RentalFilms(renting_in, renting_out);
create nonclustered index index_RentalFilms_idf_idc on RentalFilms(id_film, id_cinema);
create nonclustered index index_RentalFilms_id_cinema_in on RentalFilms(id_cinema, renting_in);
--Seances
create unique nonclustered index index_Seances_id on Seances(id_seance);
create nonclustered index index_Seances_date on Seances(date);

--Places
create unique nonclustered index index_Places_id on Places(id_place);
create nonclustered index index_Places_idh on Places(id_hall);

--PlacesSeances
create unique nonclustered index index_PlacesSeances_id on PlacesSeances(id_ps);
create nonclustered index index_PlacesSeances_idpl_ids on PlacesSeances(id_place, id_seance);

--Tickets
create unique nonclustered index index_Tickets_id on Tickets(id_ticket);
create nonclustered index index_Tickets_status on Tickets(status);