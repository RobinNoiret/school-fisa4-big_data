-- GENERATION -> DWH | dim_temps

WITH jours_generes AS (

    SELECT
        DATE_ADD('2015-01-01', pos) AS DT_JOUR

    FROM (

        SELECT 1 AS ID_LIGNE

    ) source

    LATERAL VIEW POSEXPLODE(

        SPLIT(

            REPEAT(
                'x,',
                DATEDIFF('2021-12-31', '2015-01-01') + 1
            ),

            ','

        )

    ) generated AS pos, ignored

),

jours_periode AS (

    SELECT
        DT_JOUR

    FROM jours_generes

    WHERE DT_JOUR >= '2015-01-01'
      AND DT_JOUR <= '2026-12-31'

)

INSERT OVERWRITE TABLE chu_dwh.dim_temps

PARTITION (NB_ANNEE)

SELECT
    CAST(
        FROM_UNIXTIME(
            UNIX_TIMESTAMP(DT_JOUR),
            'yyyyMMdd'
        )
        AS INT
    ) AS ID_DIM_TEMPS,

    CAST(DT_JOUR AS DATE) AS DT_JOUR,

    DAY(DT_JOUR) AS NB_JOUR,

    CASE PMOD(DATEDIFF(DT_JOUR, '1970-01-05'), 7)
        WHEN 0 THEN 'LUNDI'
        WHEN 1 THEN 'MARDI'
        WHEN 2 THEN 'MERCREDI'
        WHEN 3 THEN 'JEUDI'
        WHEN 4 THEN 'VENDREDI'
        WHEN 5 THEN 'SAMEDI'
        WHEN 6 THEN 'DIMANCHE'
    END AS NM_JOUR_SEMAINE,

    MONTH(DT_JOUR) AS NB_MOIS,

    CASE MONTH(DT_JOUR)
        WHEN 1 THEN 'JANVIER'
        WHEN 2 THEN 'FEVRIER'
        WHEN 3 THEN 'MARS'
        WHEN 4 THEN 'AVRIL'
        WHEN 5 THEN 'MAI'
        WHEN 6 THEN 'JUIN'
        WHEN 7 THEN 'JUILLET'
        WHEN 8 THEN 'AOUT'
        WHEN 9 THEN 'SEPTEMBRE'
        WHEN 10 THEN 'OCTOBRE'
        WHEN 11 THEN 'NOVEMBRE'
        WHEN 12 THEN 'DECEMBRE'
    END AS NM_MOIS,

    CASE
        WHEN PMOD(DATEDIFF(DT_JOUR, '1970-01-05'), 7) IN (5, 6)
        THEN TRUE
        ELSE FALSE
    END AS FL_WEEK_END,

    YEAR(DT_JOUR) AS NB_ANNEE

FROM jours_periode;
