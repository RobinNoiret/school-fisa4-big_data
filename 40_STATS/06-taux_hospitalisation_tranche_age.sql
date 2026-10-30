WITH hospitalisations_periode AS (

    SELECT
        CASE
            WHEN h.NB_AGE_PATIENT IS NULL THEN 'Non renseigné'
            WHEN h.NB_AGE_PATIENT < 0 THEN 'Âge invalide'
            WHEN h.NB_AGE_PATIENT < 18 THEN 'Moins de 18 ans'
            WHEN h.NB_AGE_PATIENT < 40 THEN '18 à 39 ans'
            WHEN h.NB_AGE_PATIENT < 60 THEN '40 à 59 ans'
            WHEN h.NB_AGE_PATIENT < 75 THEN '60 à 74 ans'
            ELSE '75 ans et plus'
        END AS tranche_age

    FROM chu_dwh.fact_hospitalisation h

    INNER JOIN chu_dwh.dim_temps t
        ON h.FK_DIM_TEMPS_ENTREE = t.ID_DIM_TEMPS

    WHERE t.DT_JOUR >= '2020-01-01'
      AND t.DT_JOUR <  '2021-01-01'

),

repartition AS (

    SELECT
        tranche_age,
        COUNT(*) AS nb_hospitalisations

    FROM hospitalisations_periode

    GROUP BY tranche_age

),

total AS (

    SELECT
        COUNT(*) AS nb_hospitalisations_total

    FROM hospitalisations_periode

)

SELECT
    r.tranche_age,
    r.nb_hospitalisations,
    t.nb_hospitalisations_total,

    CASE
        WHEN t.nb_hospitalisations_total = 0 THEN NULL
        ELSE ROUND(
            100.0 * r.nb_hospitalisations
            / t.nb_hospitalisations_total,
            2
        )
    END AS part_hospitalisations_pct

FROM repartition r

CROSS JOIN total t

ORDER BY r.tranche_age;
