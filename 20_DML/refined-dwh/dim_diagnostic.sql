-- REFINED -> DWH | dim_diagnostic

WITH diagnostic_source AS (

    SELECT
        UPPER(TRIM(CD_DIAGNOSTIC)) AS CD_DIAGNOSTIC,
        UPPER(TRIM(NM_DIAGNOSTIC)) AS NM_DIAGNOSTIC

    FROM chu_refined.soins_system_diagnostic

    WHERE FL_ACTIVE = TRUE
      AND CD_DIAGNOSTIC IS NOT NULL
      AND TRIM(CD_DIAGNOSTIC) <> ''

),

diagnostic_distinct AS (

    SELECT
        CD_DIAGNOSTIC,
        MAX(NM_DIAGNOSTIC) AS NM_DIAGNOSTIC

    FROM diagnostic_source

    GROUP BY CD_DIAGNOSTIC

)

INSERT OVERWRITE TABLE chu_dwh.dim_diagnostic

SELECT
    CAST(
        ROW_NUMBER() OVER (ORDER BY CD_DIAGNOSTIC)
        AS INT
    ) AS ID_DIM_DIAGNOSTIC,

    CD_DIAGNOSTIC,
    NM_DIAGNOSTIC

FROM diagnostic_distinct;
