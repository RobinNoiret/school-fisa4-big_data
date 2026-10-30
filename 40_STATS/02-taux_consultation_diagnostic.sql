-- Il faudra remplacer le CD_DIAGNOSTIC dans la clause WHERE pour obtenir le taux de consultation pour un diagnostic spécifique.

WITH consultations_periode AS (

    SELECT
        c.ID_CONSULTATION,
        d.CD_DIAGNOSTIC

    FROM chu_dwh.fact_consultation c

    INNER JOIN chu_dwh.dim_temps t
        ON c.FK_DIM_TEMPS = t.ID_DIM_TEMPS

    LEFT JOIN chu_dwh.dim_diagnostic d
        ON c.FK_DIM_DIAGNOSTIC = d.ID_DIM_DIAGNOSTIC

    WHERE t.DT_JOUR >= '2020-01-01'
      AND t.DT_JOUR <  '2021-01-01'

),

statistiques AS (

    SELECT
        COUNT(*) AS nb_consultations_total,

        SUM(
            CASE
                WHEN CD_DIAGNOSTIC = 'Q428' THEN 1
                ELSE 0
            END
        ) AS nb_consultations_diagnostic

    FROM consultations_periode

)

SELECT
    'Q428' AS cd_diagnostic,
    nb_consultations_diagnostic,
    nb_consultations_total,

    CASE
        WHEN nb_consultations_total = 0 THEN NULL
        ELSE ROUND(
            100.0 * nb_consultations_diagnostic
            / nb_consultations_total,
            2
        )
    END AS taux_consultation_diagnostic_pct

FROM statistiques;
