
ALTER TABLE musician RENAME TO singer;
ALTER TABLE singer DROP COLUMN role;
ALTER TABLE singer DROP COLUMN bandName;
DROP TABLE IF EXISTS band;
ALTER TABLE singer CHANGE musicianName singerName VARCHAR(50);
ALTER TABLE album DROP FOREIGN KEY FK_A_musicianName;
ALTER TABLE album ADD CONSTRAINT FK_A_singerName FOREIGN KEY (singerName) REFERENCES singer(singerName);
