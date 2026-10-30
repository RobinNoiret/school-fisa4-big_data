-- RAW -> REFINED | corporate_system_date

WITH source_raw AS (
    SELECT ID_TECH,
           DT_DEBUT,
           DT_FIN,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.corporate_system_date
    WHERE ID_TECH IS NOT NULL AND DT_DEBUT IS NOT NULL AND DT_FIN IS NOT NULL AND DT_DEBUT <= DT_FIN
),

deduplicated AS (
    SELECT ID_TECH,
           DT_DEBUT,
           DT_FIN,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_TECH ORDER BY NM_FILE DESC) AS RN
    FROM source_raw
)

INSERT OVERWRITE TABLE chu_refined.corporate_system_date

SELECT
    ID_TECH AS ID_TECH,
    DT_DEBUT AS DT_DEBUT,
    DT_FIN AS DT_FIN,
    CAST(1 AS BOOLEAN) AS FL_ACTIVE,
    NM_FILE AS NM_FILE,
    'system' AS NM_PROVIDER
FROM deduplicated
WHERE RN = 1;
