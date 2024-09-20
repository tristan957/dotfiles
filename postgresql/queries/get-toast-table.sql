SELECT
    relname, reltoastrelid::regclass
FROM
    pg_class
WHERE
    relname = :'table';
