-- RAW -> REFINED | corporate_system_adher

WITH source_raw AS (
    SELECT
        ID_PATIENT,
        ID_MUTUELLE,
        INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.corporate_system_adher
    WHERE ID_PATIENT IS NOT NULL
      AND ID_MUTUELLE IS NOT NULL

),

deduplicated AS (
    SELECT
        ID_PATIENT,
        ID_MUTUELLE,
        NM_FILE,
        ROW_NUMBER() OVER (
            PARTITION BY ID_PATIENT, ID_MUTUELLE
            ORDER BY NM_FILE DESC
        ) AS RN
    FROM source_raw
)

INSERT OVERWRITE TABLE chu_refined.corporate_system_adher
PARTITION (ID_MUTUELLE)

SELECT
    ID_PATIENT,
    CAST(1 AS BOOLEAN) AS FL_ACTIVE,
    NM_FILE,
    'system' AS NM_PROVIDER,
    ID_MUTUELLE

FROM deduplicated
WHERE RN = 1;
