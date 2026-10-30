-- Il faudra remplacer le code FINESS de l'établissement dans la clause WHERE pour obtenir le taux de consultation pour un établissement spécifique.

WITH consultations_periode AS (

    SELECT
        c.ID_CONSULTATION,
        e.CD_FINESS_SITE,
        e.TXT_RAISON_SOCIALE

    FROM chu_dwh.fact_consultation c

    INNER JOIN chu_dwh.dim_temps t
        ON c.FK_DIM_TEMPS = t.ID_DIM_TEMPS

    LEFT JOIN chu_dwh.dim_professionnel p
        ON c.FK_DIM_PROFESSIONNEL = p.ID_DIM_PROFESSIONNEL

    LEFT JOIN chu_dwh.dim_etablissement e
        ON p.FK_DIM_ETABLISSEMENT = e.ID_DIM_ETABLISSEMENT

    WHERE t.DT_JOUR >= '2020-01-01'
      AND t.DT_JOUR <  '2021-01-01'

),

statistiques AS (

    SELECT
        COUNT(*) AS nb_consultations_total,

        SUM(
            CASE
                WHEN CD_FINESS_SITE = '690000000' THEN 1
                ELSE 0
            END
        ) AS nb_consultations_etablissement

    FROM consultations_periode

)

SELECT
    '690000000' AS cd_finess_site,
    nb_consultations_etablissement,
    nb_consultations_total,

    CASE
        WHEN nb_consultations_total = 0 THEN NULL
        ELSE ROUND(
            100.0 * nb_consultations_etablissement
            / nb_consultations_total,
            2
        )
    END AS taux_consultation_pct

FROM statistiques;
