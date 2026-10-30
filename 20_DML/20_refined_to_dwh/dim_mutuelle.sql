-- REFINED -> DWH | dim_mutuelle

WITH mutuelle_source AS (
    SELECT ID_MUTUELLE,
           UPPER(TRIM(NM_MUTUELLE)) AS NM_MUTUELLE
    FROM chu_refined.corporate_system_mutuelle
    WHERE FL_ACTIVE = TRUE AND ID_MUTUELLE IS NOT NULL
),

mutuelle_distinct AS (
    SELECT ID_MUTUELLE,
           MAX(NM_MUTUELLE) AS NM_MUTUELLE
    FROM mutuelle_source
    GROUP BY ID_MUTUELLE
)

INSERT OVERWRITE TABLE chu_dwh.dim_mutuelle (
    ID_DIM_MUTUELLE,
    ID_MUTUELLE,
    NM_MUTUELLE
)

SELECT ROW_NUMBER() OVER (ORDER BY ID_MUTUELLE),
       ID_MUTUELLE,
       NM_MUTUELLE
    FROM mutuelle_distinct;
