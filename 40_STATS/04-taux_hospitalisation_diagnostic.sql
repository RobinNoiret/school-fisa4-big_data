WITH hospitalisations_periode AS (

    SELECT
        h.ID_HOSPITALISATION,
        d.CD_DIAGNOSTIC

    FROM chu_dwh.fact_hospitalisation h

    INNER JOIN chu_dwh.dim_temps t
        ON h.FK_DIM_TEMPS_ENTREE = t.ID_DIM_TEMPS

    LEFT JOIN chu_dwh.dim_diagnostic d
        ON h.FK_DIM_DIAGNOSTIC = d.ID_DIM_DIAGNOSTIC

    WHERE t.DT_JOUR >= '2020-01-01'
      AND t.DT_JOUR <  '2021-01-01'

),

statistiques AS (

    SELECT
        COUNT(*) AS nb_hospitalisations_total,

        SUM(
            CASE
                WHEN CD_DIAGNOSTIC = 'Q428' THEN 1
                ELSE 0
            END
        ) AS nb_hospitalisations_diagnostic

    FROM hospitalisations_periode

)

SELECT
    'Q428' AS cd_diagnostic,
    nb_hospitalisations_diagnostic,
    nb_hospitalisations_total,

    CASE
        WHEN nb_hospitalisations_total = 0 THEN NULL
        ELSE ROUND(
            100.0 * nb_hospitalisations_diagnostic
            / nb_hospitalisations_total,
            2
        )
    END AS taux_hospitalisation_diagnostic_pct

FROM statistiques;
