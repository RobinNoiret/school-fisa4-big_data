-- RAW -> REFINED | soins_system_diagnostic

WITH source_raw AS (
    SELECT ID_TECH,
           CD_DIAGNOSTIC,
           NM_DIAGNOSTIC,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.soins_system_diagnostic
    WHERE CD_DIAGNOSTIC IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           UPPER(TRIM(CD_DIAGNOSTIC)) AS CD_DIAGNOSTIC,
           UPPER(TRIM(NM_DIAGNOSTIC)) AS NM_DIAGNOSTIC,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           CD_DIAGNOSTIC,
           NM_DIAGNOSTIC,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY CD_DIAGNOSTIC ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.soins_system_diagnostic (
    ID_TECH,
    CD_DIAGNOSTIC,
    NM_DIAGNOSTIC,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       CD_DIAGNOSTIC,
       NM_DIAGNOSTIC,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
    WHERE RN = 1;
