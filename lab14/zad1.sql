-- Wykorzystując XPATH pokazać osoby z emailem w domenie o2.pl

SELECT id, xpath('//lname/text()', data)::text,
           xpath('//address/city/text()', data)::text,
           xpath('//contact/email/text()',data)::text
FROM xml_table
WHERE cast(xpath('//contact/email/text()[end-with(., "@o2.pl")]', data) as text[]) != '{}';