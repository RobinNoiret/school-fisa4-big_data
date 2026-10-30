-- RAW -> REFINED | corporate_system_specialites

WITH source_raw AS (
    SELECT ID_TECH,
           CD_SPECIALITE,
           NM_FONCTION,
           NM_SPECIALITE,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.corporate_system_specialites
    WHERE CD_SPECIALITE IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           UPPER(TRIM(CD_SPECIALITE)) AS CD_SPECIALITE,
           UPPER(TRIM(NM_FONCTION)) AS NM_FONCTION,
           UPPER(TRIM(NM_SPECIALITE)) AS NM_SPECIALITE,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           CD_SPECIALITE,
           NM_FONCTION,
           NM_SPECIALITE,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY CD_SPECIALITE ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.corporate_system_specialites (
    ID_TECH,
    CD_SPECIALITE,
    NM_FONCTION,
    NM_SPECIALITE,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       CD_SPECIALITE,
       NM_FONCTION,
       NM_SPECIALITE,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
    WHERE RN = 1;
