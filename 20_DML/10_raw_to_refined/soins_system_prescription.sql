-- RAW -> REFINED | soins_system_prescription

WITH source_raw AS (
    SELECT ID_TECH,
           ID_CONSULTATION,
           CD_CIS,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.soins_system_prescription
    WHERE ID_CONSULTATION IS NOT NULL AND CD_CIS IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           ID_CONSULTATION,
           UPPER(TRIM(CD_CIS)) AS CD_CIS,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           ID_CONSULTATION,
           CD_CIS,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_CONSULTATION, CD_CIS ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.soins_system_prescription (
    ID_TECH,
    ID_CONSULTATION,
    CD_CIS,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       ID_CONSULTATION,
       CD_CIS,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
    WHERE RN = 1;
