-- RAW -> REFINED | corporate_system_laboratoire

WITH source_raw AS (
    SELECT ID_TECH,
           ID_LABORATOIRE,
           NM_LABORATOIRE,
           NM_PAYS,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.corporate_system_laboratoire
    WHERE ID_LABORATOIRE IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           ID_LABORATOIRE,
           UPPER(TRIM(NM_LABORATOIRE)) AS NM_LABORATOIRE,
           UPPER(TRIM(NM_PAYS)) AS NM_PAYS,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           ID_LABORATOIRE,
           NM_LABORATOIRE,
           NM_PAYS,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_LABORATOIRE ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.corporate_system_laboratoire (
    ID_TECH,
    ID_LABORATOIRE,
    NM_LABORATOIRE,
    NM_PAYS,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       ID_LABORATOIRE,
       NM_LABORATOIRE,
       NM_PAYS,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
    WHERE RN = 1;
