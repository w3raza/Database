CREATE TABLE sample_table ( 
fname varchar, 
lname varchar, 
city varchar, 
email varchar, 
phone varchar, 
id varchar ) ;

INSERT INTO sample_table VALUES
( 'Adam', 'Abacki', 'Krakow', 'abacki@o2.pl', '123 400 212', '10001'),
( 'Marta', 'Babacka', 'Konin', 'babacki@onet.pl', '411 909 123', '11011'),
( 'Bogdan', 'Cabacki', 'Tarnow', 'cabacki@wp.pl', '222 190 100', '20010'),
( 'Marek', 'Dadacki', 'Gdynia', 'dadacki@google.com', '431 222 100', '10022'),
( 'Edward', 'Kabacki', 'Szczecin', 'kabacki@o2.pl', '780 159 100', '21145') ;


-- xmlelement
SELECT xmlelement ( name  fname, fname) FROM sample_table;

SELECT xmlelement ( name  fname, fname)::text || xmlelement( name  lname, lname) FROM sample_table;

-- xmlattributes
SELECT xmlelement ( name  lname, 
                    xmlattributes ( email as email ) , 
                    lname ) 
FROM sample_table;

-- xmlforest
SELECT xmlelement ( name  user, 
                    xmlattributes ( id as id ), 
                    xmlforest ( fname as fname, lname as lname, email as email )) 
FROM sample_table ;

-- xmlagg - twaorzy dokument danych osob 
SELECT xmlelement ( name  users, 
                  ( SELECT xmlagg ( xmlelement ( name lname, lname)) FROM sample_table ) ) ;

SELECT xmlelement ( name  users, 
                    ( SELECT xmlagg ( 
                          xmlelement ( name  user, 
                                       xmlattributes ( id as id ), 
                                       xmlforest ( fname as fname, lname as lname, email as email ))) 
                      FROM sample_table ) ) ;

-- xmlroot
SELECT xmlroot ( xmlelement ( name  users, 
                            ( SELECT xmlagg( xmlelement ( name lname, lname)) FROM sample_table ) ), 
                version '1.0', standalone yes );
                


-- odwzorowanie struktur
SELECT table_to_xml('sample_table',true,true,'');
SELECT table_to_xmlschema('sample_table',true,true,'');
SELECT table_to_xml_and_xmlschema('sample_table',true,true,'');
SELECT query_to_xml_and_xmlschema('SELECT lname FROM sample_table',true,true,'');



---------------------------------------------------------------------------------------

CREATE TABLE xml_table ( id varchar, data xml ) ;

SELECT xmlelement ( name  user, xmlattributes ( id as id ),
                    xmlelement ( name fname, fname ),
                    xmlelement ( name lname, lname ),
                    xmlelement ( name address, xmlelement ( name city, city )),
                    xmlelement ( name contact, xmlforest ( email, phone )) )
FROM sample_table ;


INSERT INTO xml_table SELECT id, xmlelement ( name  user, xmlattributes ( id as id ),
                      xmlelement ( name fname, fname ),
                      xmlelement ( name lname, lname ),
                      xmlelement ( name address, xmlelement ( name city, city )),
                      xmlelement ( name contact, xmlforest ( email, phone )) )
                      FROM sample_table ;

SELECT id, data FROM xml_table;  
-----------------------------

SET xmloption TO DOCUMENT;
SELECT xml_is_well_formed('<>');   
SELECT xml_is_well_formed('<aa></aa>');
SELECT xml_is_well_formed('aaa');
SET xmloption TO CONTENT;
SELECT xml_is_well_formed('<>');   
SELECT xml_is_well_formed('<aa></aa>');
SELECT xml_is_well_formed('aaa');

------------------------------------

-- xpath

SELECT id, xpath('//lname/text()', data)::text,
           xpath('//address/city/text()', data)::text
FROM xml_table
WHERE cast(xpath('//contact[email="dadacki@google.com"]', data) as text[]) != '{}';



SELECT id, unnest(xpath('//lname/text()', data))::text,
           unnest(xpath('//address/city/text()', data))::text
FROM xml_table
WHERE cast(xpath('//contact[email="dadacki@google.com"]', data) as text[]) != '{}';


SELECT id, unnest(xpath('//lname/text()', data))::text,
           unnest(xpath('//address/city/text()', data))::text
FROM xml_table
WHERE cast(xpath('//contact/email/text()', data) as text[]) = '{dadacki@google.com}';


SELECT id, xpath('//lname/text()', data)::text,
           xpath('//address/city/text()', data)::text
FROM xml_table
WHERE xpath('//contact/email/text()', data)::text = '{dadacki@google.com}'; 


SELECT id, xpath_exists('//contact/phone/text()', data) FROM xml_table ;

------

-- hstore
CREATE EXTENSION hstore;

CREATE TABLE hstore_table ( id INT, time DATE, data hstore ) ;

INSERT INTO hstore_table VALUES
( 1, '2017-01-01 00:00:00', '"press"=>"1021", "temp"=>"0.0", "wind"=>"2", "humi"=>"55"'),
( 2, '2017-01-02 00:00:00', '"press"=>"1010", "temp"=>"1.0", "wind"=>"1", "humi"=>"65"'),
( 3, '2017-01-03 00:00:00', '"press"=>"1005", "temp"=>"2.0", "wind"=>"5", "humi"=>"45"'),
( 4, '2017-01-04 00:00:00', '"press"=>"1011", "temp"=>"0.0", "wind"=>"3", "humi"=>"35"'),
( 5, '2017-01-05 00:00:00', '"press"=>"1015", "temp"=>"-1.0", "wind"=>"0", "humi"=>"25"'),
( 6, '2017-01-06 00:00:00', '"press"=>"1016", "temp"=>"-5.0", "wind"=>"2", "humi"=>"15"'),
( 7, '2017-01-07 00:00:00', '"press"=>"1014", "temp"=>"-8.0", "wind"=>"0", "humi"=>"15"');

SELECT data FROM hstore_table;

SELECT data->'temp' AS temp FROM hstore_table;

SELECT time, data->'temp' AS temp FROM hstore_table WHERE data->'temp' = '0.0';

UPDATE hstore_table SET data = data || '"prog"=>"v011.2017"' :: hstore;

UPDATE hstore_table SET data = data || '"prog"=>"v012.2017"' :: hstore;

UPDATE hstore_table SET data = delete ( data, 'prog' );

UPDATE hstore_table SET data = data || '"temp0"=>"-1.0"'::hstore WHERE id IN (2,3); 


-- akeys, skeys
SELECT akeys(data) FROM hstore_table;

SELECT skeys(data) FROM hstore_table;

SELECT avals(data) FROM hstore_table;

SELECT svals(data) FROM hstore_table;


--json, rdbms
SELECT id, time, hstore_to_json(data) FROM hstore_table;

SELECT id, time, (each(data)).*  FROM hstore_table;
-----------------------------------------------------------------


