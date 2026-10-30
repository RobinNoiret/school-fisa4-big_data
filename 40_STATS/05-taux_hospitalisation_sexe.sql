WITH patients_hospitalises AS (

    SELECT DISTINCT
        h.FK_DIM_PATIENT

    FROM chu_dwh.fact_hospitalisation h

    INNER JOIN chu_dwh.dim_temps t
        ON h.FK_DIM_TEMPS_ENTREE = t.ID_DIM_TEMPS

    WHERE t.DT_JOUR >= '2020-01-01'
      AND t.DT_JOUR <  '2021-01-01'
      AND h.FK_DIM_PATIENT IS NOT NULL

),

statistiques AS (

    SELECT
        p.CD_SEXE,

        COUNT(*) AS nb_patients_total,

        SUM(
            CASE
                WHEN h.FK_DIM_PATIENT IS NOT NULL THEN 1
                ELSE 0
            END
        ) AS nb_patients_hospitalises

    FROM chu_dwh.dim_patient p

    LEFT JOIN patients_hospitalises h
        ON p.ID_DIM_PATIENT = h.FK_DIM_PATIENT

    GROUP BY
        p.CD_SEXE

)

SELECT
    CD_SEXE,
    nb_patients_hospitalises,
    nb_patients_total,

    CASE
        WHEN nb_patients_total = 0 THEN NULL
        ELSE ROUND(
            100.0 * nb_patients_hospitalises
            / nb_patients_total,
            2
        )
    END AS taux_hospitalisation_pct

FROM statistiques

ORDER BY CD_SEXE;
