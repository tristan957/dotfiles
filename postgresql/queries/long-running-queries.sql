SELECT
    pid, datname, usename, state, backend_xmin, backend_xid
FROM
    pg_stat_activity
WHERE
    backend_xmin IS NOT NULL OR backend_xid IS NOT NULL
ORDER BY
    GREATEST(AGE(backend_xmin), AGE(backend_xid))
    DESC;
