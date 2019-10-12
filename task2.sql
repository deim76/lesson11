-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.
use vk;

DROP TEMPORARY TABLE IF EXISTS temp;
DROP TEMPORARY TABLE IF EXISTS temp1;
CREATE TEMPORARY TABLE temp (f int);
CREATE TEMPORARY TABLE temp1 (f int);
insert into temp (
WITH RECURSIVE tab AS
(
SELECT 1 as f
UNION ALL
SELECT f+1 FROM tab WHERE f < 1000
)
SELECT * From tab
);
insert into temp1 (
WITH RECURSIVE tab AS
(
SELECT 1 as f
UNION ALL
SELECT f+1 FROM tab WHERE f < 1000
)
SELECT * From tab
);

INSERT INTO users (first_name,last_name,email,phone)(SELECT
(SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 10)) as first_name,
(SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 10)) as last_name,
concat((SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 8)),'@',(SELECT SUBSTRING(MD5(RAND()) FROM 1 FOR 5)),'.ru') AS email,
(SELECT SUBSTRING(RAND() FROM 1 FOR 8)) AS phone
 FROM temp
 JOIN temp1
 limit 1000000);
-- Вставку сразу 1000000 MySQL на компьютере не потянул но по 500000 вставляет хорошо 

