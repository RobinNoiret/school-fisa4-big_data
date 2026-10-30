-- RAW -> REFINED | corporate_system_salle

WITH source_raw AS (
    SELECT ID_TECH,
           ID_SALLE,
           ID_CONSULTATION,
           CD_BLOC,
           NB_ETAGE,
           NB_SALLE,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.corporate_system_salle
    WHERE ID_SALLE IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           TRIM(ID_SALLE) AS ID_SALLE,
           ID_CONSULTATION,
           UPPER(TRIM(CD_BLOC)) AS CD_BLOC,
           TRIM(NB_ETAGE) AS NB_ETAGE,
           TRIM(NB_SALLE) AS NB_SALLE,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           ID_SALLE,
           ID_CONSULTATION,
           CD_BLOC,
           NB_ETAGE,
           NB_SALLE,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_SALLE ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.corporate_system_salle (
    ID_TECH,
    ID_SALLE,
    ID_CONSULTATION,
    CD_BLOC,
    NB_ETAGE,
    NB_SALLE,
    FL_ACTIVE,
    NM_FILE,
    NM_PROVIDER
)

SELECT ID_TECH,
       ID_SALLE,
       ID_CONSULTATION,
       CD_BLOC,
       NB_ETAGE,
       NB_SALLE,
       CAST(1 AS BOOLEAN),
       NM_FILE,
       'system'
    FROM deduplicated
    WHERE RN = 1;
