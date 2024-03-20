CREATE TABLE IF NOT EXISTS band (bandName varchar(50) PRIMARY KEY, creation YEAR, genre varchar(50));
INSERT INTO band(bandName, creation, genre)
VALUES
('Crazy Duo', 2015, 'rock'),
('Luna', 2009, 'classical'),
('Mysterio', 2019, 'pop');

ALTER TABLE singer RENAME TO musician;


ALTER TABLE musician CHANGE COLUMN singerName musicianName varchar(50);

ALTER TABLE musician
ADD COLUMN role varchar(50),
ADD COLUMN bandName varchar(50),
ADD FOREIGN KEY(bandName) REFERENCES band(bandName) ON DELETE SET NULL;

UPDATE musician SET role = 'vocals', bandName = 'Crazy Duo' WHERE musician.musicianName = 'Alina';
UPDATE musician SET role = 'guitar', bandName = 'Mysterio' WHERE musician.musicianName = 'Mysterio';
UPDATE musician SET role = 'percussion', bandName = 'Crazy Duo' WHERE musician.musicianName = 'Rainbow';
UPDATE musician set role = 'piano', bandName = 'Luna' WHERE musician.musicianName = 'Luna';


