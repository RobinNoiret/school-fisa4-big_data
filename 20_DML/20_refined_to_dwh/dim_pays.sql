-- REFINED -> DWH | dim_pays

WITH pays_source AS (
    SELECT UPPER(TRIM(NM_PAYS)) AS NM_PAYS
    FROM chu_refined.soins_system_patient
    WHERE FL_ACTIVE = TRUE AND NM_PAYS IS NOT NULL AND TRIM(NM_PAYS) <> ''
    UNION ALL
    SELECT UPPER(TRIM(NM_PAYS)) AS NM_PAYS
    FROM chu_refined.corporate_system_etablissement
    WHERE FL_ACTIVE = TRUE AND NM_PAYS IS NOT NULL AND TRIM(NM_PAYS) <> ''
    UNION ALL
    SELECT UPPER(TRIM(NM_PAYS)) AS NM_PAYS
    FROM chu_refined.demographie_insee_deces
    WHERE FL_ACTIVE = TRUE AND NM_PAYS IS NOT NULL AND TRIM(NM_PAYS) <> ''
),

pays_distinct AS (
    SELECT DISTINCT NM_PAYS
    FROM pays_source
)

INSERT OVERWRITE TABLE chu_dwh.dim_pays (
    ID_DIM_PAYS,
    NM_PAYS
)

SELECT ROW_NUMBER() OVER (ORDER BY NM_PAYS),
       NM_PAYS
    FROM pays_distinct;
