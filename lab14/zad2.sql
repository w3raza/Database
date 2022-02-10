-- Wykorzystując XPATH pokazać osoby z id w zakresie 10000 do 20000.

SELECT id, person->'person'->>'email' FROM json_table
WHERE person->'person'->>'id' >= '10000' AND person->'person'->>'id' <= '20000';


SELECT id, xpath('//lname/text()', data)::text,
           xpath('//address/city/text()', data)::text,
           xpath('//contact/email/text()',data)::text
FROM xml_table
WHERE id BETWEEN '10000' AND '20000';