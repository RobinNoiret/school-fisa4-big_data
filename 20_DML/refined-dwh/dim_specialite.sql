-- REFINED -> DWH | dim_specialite

WITH specialite_source AS (

    SELECT
        UPPER(TRIM(CD_SPECIALITE)) AS CD_SPECIALITE,
        UPPER(TRIM(NM_SPECIALITE)) AS NM_SPECIALITE,
        UPPER(TRIM(NM_FONCTION)) AS NM_FONCTION

    FROM chu_refined.corporate_system_specialites

    WHERE FL_ACTIVE = TRUE
      AND CD_SPECIALITE IS NOT NULL
      AND TRIM(CD_SPECIALITE) <> ''

),

specialite_distinct AS (

    SELECT
        CD_SPECIALITE,
        MAX(NM_SPECIALITE) AS NM_SPECIALITE,
        MAX(NM_FONCTION) AS NM_FONCTION

    FROM specialite_source

    GROUP BY CD_SPECIALITE

)

INSERT OVERWRITE TABLE chu_dwh.dim_specialite

SELECT
    CAST(
        ROW_NUMBER() OVER (ORDER BY CD_SPECIALITE)
        AS INT
    ) AS ID_DIM_SPECIALITE,

    CD_SPECIALITE,
    NM_SPECIALITE,
    NM_FONCTION

FROM specialite_distinct;
