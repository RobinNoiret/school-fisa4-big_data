-- RAW -> REFINED | soins_system_patient

WITH source_raw AS (
    SELECT ID_TECH,
           ID_PATIENT,
           CD_SEXE,
           NM_VILLE,
           CD_DEPARTEMENT,
           NM_PAYS,
           DT_NAISSANCE,
           CD_GROUPE_SANGUIN,
           NB_POID,
           NB_TAILLE,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.soins_system_patient
    WHERE ID_PATIENT IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           ID_PATIENT,
           UPPER(TRIM(CD_SEXE)) AS CD_SEXE,
           UPPER(TRIM(NM_VILLE)) AS NM_VILLE,
           UPPER(TRIM(CD_DEPARTEMENT)) AS CD_DEPARTEMENT,
           UPPER(TRIM(NM_PAYS)) AS NM_PAYS,
           DT_NAISSANCE,
           UPPER(TRIM(CD_GROUPE_SANGUIN)) AS CD_GROUPE_SANGUIN,
           TRIM(NB_POID) AS NB_POID,
           TRIM(NB_TAILLE) AS NB_TAILLE,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           ID_PATIENT,
           CD_SEXE,
           NM_VILLE,
           CD_DEPARTEMENT,
           NM_PAYS,
           DT_NAISSANCE,
           CD_GROUPE_SANGUIN,
           NB_POID,
           NB_TAILLE,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY ID_PATIENT ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.soins_system_patient

SELECT
    ID_TECH AS ID_TECH,
    ID_PATIENT AS ID_PATIENT,
    CD_SEXE AS CD_SEXE,
    NM_VILLE AS NM_VILLE,
    CD_DEPARTEMENT AS CD_DEPARTEMENT,
    NM_PAYS AS NM_PAYS,
    DT_NAISSANCE AS DT_NAISSANCE,
    CD_GROUPE_SANGUIN AS CD_GROUPE_SANGUIN,
    NB_POID AS NB_POID,
    NB_TAILLE AS NB_TAILLE,
    CAST(1 AS BOOLEAN) AS FL_ACTIVE,
    NM_FILE AS NM_FILE,
    'system' AS NM_PROVIDER
FROM deduplicated
WHERE RN = 1;
