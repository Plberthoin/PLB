--
-- CREATION TABLE des sessions nodejs
--
CREATE or replace TABLE  lstnodses (
  port    CHAR ( 4 ) NOT NULL WITH DEFAULT,
  scripte CHAR ( 50) NOT NULL WITH DEFAULT,
  start   CHAR ( 4 ) NOT NULL WITH DEFAULT,
  PRIMARY KEY (port )
  ) ;
