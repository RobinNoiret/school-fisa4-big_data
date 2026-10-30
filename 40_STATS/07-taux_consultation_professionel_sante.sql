WITH consultations_periode AS (

    SELECT
        c.ID_CONSULTATION,
        c.FK_DIM_PROFESSIONNEL

    FROM chu_dwh.fact_consultation c

    INNER JOIN chu_dwh.dim_temps t
        ON c.FK_DIM_TEMPS = t.ID_DIM_TEMPS

    WHERE t.DT_JOUR >= '2020-01-01'
      AND t.DT_JOUR <  '2021-01-01'

),

consultations_par_professionnel AS (

    SELECT
        FK_DIM_PROFESSIONNEL,
        COUNT(*) AS nb_consultations_professionnel

    FROM consultations_periode

    GROUP BY FK_DIM_PROFESSIONNEL

),

total AS (

    SELECT
        COUNT(*) AS nb_consultations_total

    FROM consultations_periode

)

SELECT
    p.ID_PROFESSIONNEL,
    p.TXT_CATEGORIE_PRO,
    p.TXT_PROFESSION,

    c.nb_consultations_professionnel,
    t.nb_consultations_total,

    CASE
        WHEN t.nb_consultations_total = 0 THEN NULL
        ELSE ROUND(
            100.0 * c.nb_consultations_professionnel
            / t.nb_consultations_total,
            2
        )
    END AS taux_consultation_professionnel_pct

FROM consultations_par_professionnel c

LEFT JOIN chu_dwh.dim_professionnel p
    ON c.FK_DIM_PROFESSIONNEL = p.ID_DIM_PROFESSIONNEL

CROSS JOIN total t

ORDER BY c.nb_consultations_professionnel DESC;
