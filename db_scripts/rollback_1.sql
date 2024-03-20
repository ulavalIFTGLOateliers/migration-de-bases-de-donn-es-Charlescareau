ALTER TABLE musician DROP FOREIGN KEY musician_ibfk_1;

ALTER TABLE musician
DROP COLUMN role,
DROP COLUMN bandName;

ALTER TABLE musician CHANGE COLUMN musicianName singerName varchar(50);

ALTER TABLE musician RENAME TO singer;

DROP TABLE IF EXISTS band;