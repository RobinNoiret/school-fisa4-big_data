-- RAW -> REFINED | soins_system_consultation

WITH source_raw AS (
    SELECT ID_TECH,
           ID_CONSULTATION,
           ID_MUTUELLE,
           ID_PATIENT,
           ID_PROFESSIONNEL_SANTE,
           CD_DIAGNOSTIC,
           TXT_MOTIF,
           DT_CONSULTATION,
           TS_DEBUT,
           TS_FIN,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.soins_system_consultation
    WHERE ID_CONSULTATION IS NOT NULL AND DT_CONSULTATION IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           ID_CONSULTATION,
           ID_MUTUELLE,
           ID_PATIENT,
           TRIM(ID_PROFESSIONNEL_SANTE) AS ID_PROFESSIONNEL_SANTE,
           UPPER(TRIM(CD_DIAGNOSTIC)) AS CD_DIAGNOSTIC,
           UPPER(TRIM(TXT_MOTIF)) AS TXT_MOTIF,
           DT_CONSULTATION,
           TRIM(TS_DEBUT) AS TS_DEBUT,
           TRIM(TS_FIN) AS TS_FIN,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           ID_CONSULTATION,
           ID_MUTUELLE,
           ID_PATIENT,
           ID_PROFESSIONNEL_SANTE,
           CD_DIAGNOSTIC,
           TXT_MOTIF,
           DT_CONSULTATION,
           TS_DEBUT,
           TS_FIN,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_CONSULTATION ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.soins_system_consultation (
    ID_TECH,
    ID_CONSULTATION,
    ID_MUTUELLE,
    ID_PATIENT,
    ID_PROFESSIONNEL_SANTE,
    CD_DIAGNOSTIC,
    TXT_MOTIF,
    DT_CONSULTATION,
    TS_DEBUT,
    TS_FIN,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       ID_CONSULTATION,
       ID_MUTUELLE,
       ID_PATIENT,
       ID_PROFESSIONNEL_SANTE,
       CD_DIAGNOSTIC,
       TXT_MOTIF,
       DT_CONSULTATION,
       TS_DEBUT,
       TS_FIN,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
WHERE RN = 1;
