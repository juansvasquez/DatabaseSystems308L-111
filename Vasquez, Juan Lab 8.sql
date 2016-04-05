-- This file creates the EON Casting Database --
-- Author: Juan S. Vasquez --

drop database if exists casting_db;
create database casting_db;
use casting_db;

CREATE TABLE IF NOT EXISTS People(
PeopleID INT NOT NULL,
Name TEXT,
Address TEXT,
Spouse TEXT,
PRIMARY KEY(PeopleID),
); 

CREATE TABLE IF NOT EXISTS Actors(
PeopleID INT NOT NULL REFERENCES People(PeopleID),
BirthDate DATE,
HairColor TEXT,
EYE COLOR TEXT,
InchHeight INT,
Weight INT,
PrefColor TEXT,
SAGAnniv DATE,
PRIMARY KEY(PeopleID)
);

CREATE TABLE IF NOT EXISTS Directors(
PeopleID INT NOT NULL REFERENCES People(PeopleID),
FilmSchool TEXT,
DGAnniv DATE,
PrefLensMaker TEXT,
PRIMARY KEY(PeopleID)
);

CREATE TABLE IF NOT EXISTS MovieDirectors(
MovieID INT NOT NULL,
PeopleID INT NOT NULL REFERENCES People(PeopleID),
PRIMARY KEY(MovieID),
PRIMARY KEY(PeopleID)
);

CREATE TABLE IF NOT EXISTS MovieActors(
MovieID INT NOT NULL REFERENCES Movie(MovieID),
PeopleID INT NOT NULL REFERENCES People(PeopleID),
PRIMARY KEY(MovieID),
PRIMARY KEY(PeopleID)
);

CREATE TABLE IF NOT EXISTS Movies(
MovieID INT NOT NULL,
MovieName TEXT,
ReleaseYear INT,
NumberMPAA INT,
DomSales USD TEXT,
IntSalesUSD TEXT,
HomeVidSalesUSD TEXT,
PRIMARY KEY(MovieID)
);

-- The Sean Connery Query: Write a query to show all the directors --
-- with whom "Sean Connery" has worked. --

SELECT PeopleID
FROM MovieDirectors
WHERE MovieID IN(
		SELECT MovieID
		FROM MovieActors
		WHERE PeopleID IN(
			SELECT PeopleID
			FROM People
			WHERE Name = "Sean Connery"
		)
);






