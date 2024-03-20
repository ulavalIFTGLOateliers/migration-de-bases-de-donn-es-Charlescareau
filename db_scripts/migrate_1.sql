CREATE TABLE IF NOT EXISTS band (bandName VARCHAR(50), creation YEAR, genre VARCHAR(50), PRIMARY KEY(bandName));
INSERT INTO band VALUES ('Crazy Duo', 2015, 'rock'), ('Luna', 2009, 'Classical'), ('Mysterio', 2019, 'pop');
CREATE TABLE IF NOT EXISTS singer (
    singerName VARCHAR(50),
    firstName VARCHAR(50),
    lastName VARCHAR(50),
    age INT,
    PRIMARY KEY(singerName)
);

CREATE TABLE IF NOT EXISTS label (
    labelName VARCHAR(50),
    creation YEAR,
    genre VARCHAR(50),
    PRIMARY KEY(labelName)
);

CREATE TABLE IF NOT EXISTS album (
    albumName VARCHAR(50),
    singerName VARCHAR(50),
    year YEAR,
    labelName VARCHAR(50),
    PRIMARY KEY(albumName),
    CONSTRAINT FK_A_singerName FOREIGN KEY (singerName) REFERENCES singer(singerName),
    FOREIGN KEY (labelName) REFERENCES label(labelName)
);

INSERT INTO singer (singerName, firstName, lastName, age) VALUES
('Alina', 'Darcy', 'Boles', 32),
('Mysterio', 'Jessie', 'Chancey', 23),
('Rainbow', 'Sarah', 'Derrick', 47),
('Luna', 'Emily', 'Seibold', 31)
ON DUPLICATE KEY UPDATE
firstName=VALUES(firstName), lastName=VALUES(lastName), age=VALUES(age);

INSERT INTO label (labelName, creation, genre)
VALUES
    ("World Music", 2002, "pop"),
    ("Dark Matter", 2015, "rock"),
    ("Four Seasons", 1999, "classical")
ON DUPLICATE KEY UPDATE
    creation = VALUES(creation), genre = VALUES(genre);


INSERT INTO album (albumName, singerName, year, labelName) VALUES
('World of Mysteries', 'Mysterio', 2019, 'Dark Matter'),
('Second Mystery', 'Mysterio', 2021, 'World Music'),
('Concertos', 'Luna', 2009, 'Four Seasons')
ON DUPLICATE KEY UPDATE
singerName = VALUES(singerName), year = VALUES(year), labelName = VALUES(labelName);

-- Now, to perform the migration:
-- First, rename the `singer` table to `musician`
ALTER TABLE singer RENAME TO musician;
ALTER TABLE musician CHANGE singerName musicianName VARCHAR(50);
-- Then, add the new columns `role` and `bandName` to the `musician` table
ALTER TABLE musician ADD role VARCHAR(50);
ALTER TABLE musician ADD bandName VARCHAR(50);

-- Next, populate the `role` and `bandName` fields in the new `musician` table
UPDATE musician SET role = 'vocals', bandName = 'Crazy Duo' WHERE firstName = 'Darcy';
UPDATE musician SET role = 'guitar', bandName = 'Mysterio' WHERE firstName = 'Jessie';
UPDATE musician SET role = 'percussion', bandName = 'Crazy Duo' WHERE firstName = 'Sarah';
UPDATE musician SET role = 'piano', bandName = 'Luna' WHERE firstName = 'Emily';

-- Prepare the `album` table for renaming the foreign key column
ALTER TABLE album DROP FOREIGN KEY FK_A_singerName;

ALTER TABLE album ADD CONSTRAINT FK_A_musicianName FOREIGN KEY (singerName) REFERENCES musician(musicianName);




