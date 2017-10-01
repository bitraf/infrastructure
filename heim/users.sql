\set QUIET
\timing off

COPY (

WITH paying AS (
    SELECT
        am.account,
        (0 < am.price OR am.flag IS NOT DISTINCT FROM 'm_office') AS paying
    FROM active_members am
), users AS (
    SELECT
        lower(ac.name) AS username,
        au.data AS password,
        am.full_name AS fullname,
        CASE WHEN p.paying THEN '/bin/bash' ELSE '/bin/false' END AS shell
    FROM active_members am
    INNER JOIN auth au USING (account)
    INNER JOIN accounts ac ON ac.id = am.account
    INNER JOIN paying p USING (account)
    WHERE au.realm = 'login'
    ORDER BY ac.id
)
    SELECT
        json_build_object(
            'users', json_agg(
                json_build_object(
                    'username', u.username,
                    'password', u.password,
                    'fullname', u.fullname,
                    'shell', u.shell
                )
            )
        )
    FROM users u

) TO STDOUT
;
