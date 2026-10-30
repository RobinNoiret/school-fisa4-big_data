-- RAW -> REFINED | corporate_system_mutuelle

WITH source_raw AS (
    SELECT ID_TECH,
           ID_MUTUELLE,
           NM_MUTUELLE,
           TXT_ADRESSE,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.corporate_system_mutuelle
    WHERE ID_MUTUELLE IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           ID_MUTUELLE,
           UPPER(TRIM(NM_MUTUELLE)) AS NM_MUTUELLE,
           UPPER(TRIM(TXT_ADRESSE)) AS TXT_ADRESSE,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           ID_MUTUELLE,
           NM_MUTUELLE,
           TXT_ADRESSE,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_MUTUELLE ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.corporate_system_mutuelle (
    ID_TECH,
    ID_MUTUELLE,
    NM_MUTUELLE,
    TXT_ADRESSE,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       ID_MUTUELLE,
       NM_MUTUELLE,
       TXT_ADRESSE,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
    WHERE RN = 1;
