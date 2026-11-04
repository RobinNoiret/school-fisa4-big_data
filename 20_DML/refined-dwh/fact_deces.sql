-- REFINED -> DWH | fact_deces

WITH deces_source AS (

    SELECT
        ID_TECH,
        UPPER(TRIM(CD_LIEU_DECES)) AS CD_LIEU_DECES,
        CAST(NM_SEXE AS STRING) AS CD_SEXE_SOURCE,
        DT_NAISSANCE,
        DT_DECES

    FROM chu_refined.demographie_insee_deces

    WHERE FL_ACTIVE = TRUE

),

deces_prepared AS (

    SELECT
        ID_TECH,
        CD_LIEU_DECES,

        CASE CD_SEXE_SOURCE
            WHEN '1' THEN 'M'
            WHEN '2' THEN 'F'
            ELSE CD_SEXE_SOURCE
        END AS CD_SEXE,

        DT_DECES AS NB_ANNEE_DECES,

        CASE
            WHEN DT_NAISSANCE IS NOT NULL
             AND DT_DECES IS NOT NULL
             AND DT_DECES >= DT_NAISSANCE
            THEN DT_DECES - DT_NAISSANCE
            ELSE NULL
        END AS NB_AGE_DECES

    FROM deces_source

),

localisations_uniques AS (

    SELECT
        CD_COMMUNE,

        CASE
            WHEN COUNT(*) = 1 THEN MIN(ID_DIM_LOCALISATION)
            ELSE NULL
        END AS ID_DIM_LOCALISATION

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = null
      AND CD_COMMUNE IS NOT NULL
      AND TRIM(CD_COMMUNE) <> ''

    GROUP BY CD_COMMUNE

)

INSERT OVERWRITE TABLE chu_dwh.fact_deces

PARTITION (NB_ANNEE_DECES)

SELECT
    CAST(
        ROW_NUMBER() OVER (
            ORDER BY src.ID_TECH
        )
        AS INT
    ) AS ID_FAIT_DECES,

    loc.ID_DIM_LOCALISATION AS FK_DIM_LOCALISATION_DECES,

    CAST(NULL AS INT) AS FK_DIM_LOCALISATION_NAISSANCE,

    src.CD_SEXE,
    src.NB_AGE_DECES,

    src.NB_ANNEE_DECES

FROM deces_prepared src

LEFT JOIN localisations_uniques loc
    ON loc.CD_COMMUNE = src.CD_LIEU_DECES;
