-- RAW -> REFINED | demographie_insee_deces

WITH source_raw AS (
    SELECT ID_TECH,
           NM_SEXE,
           DT_NAISSANCE,
           CD_LIEU_NAISSANCE,
           NM_VILLE,
           NM_PAYS,
           DT_DECES,
           CD_LIEU_DECES,
           NB_ACTE_DECES,
           INPUT__FILE__NAME AS NM_FILE
    FROM chu_raw.demographie_insee_deces
    WHERE NB_ACTE_DECES IS NOT NULL AND DT_DECES IS NOT NULL
),

prepared AS (
    SELECT ID_TECH,
           NM_SEXE,
           DT_NAISSANCE,
           UPPER(TRIM(CD_LIEU_NAISSANCE)) AS CD_LIEU_NAISSANCE,
           UPPER(TRIM(NM_VILLE)) AS NM_VILLE,
           UPPER(TRIM(NM_PAYS)) AS NM_PAYS,
           DT_DECES,
           UPPER(TRIM(CD_LIEU_DECES)) AS CD_LIEU_DECES,
           TRIM(NB_ACTE_DECES) AS NB_ACTE_DECES,
           NM_FILE
    FROM source_raw
),

deduplicated AS (
    SELECT ID_TECH,
           NM_SEXE,
           DT_NAISSANCE,
           CD_LIEU_NAISSANCE,
           NM_VILLE,
           NM_PAYS,
           DT_DECES,
           CD_LIEU_DECES,
           NB_ACTE_DECES,
           NM_FILE,
           ROW_NUMBER() OVER (PARTITION BY NB_ACTE_DECES ORDER BY NM_FILE DESC, ID_TECH DESC) AS RN
    FROM prepared
)

INSERT OVERWRITE TABLE chu_refined.demographie_insee_deces

SELECT
    ID_TECH AS ID_TECH,
    NM_SEXE AS NM_SEXE,
    DT_NAISSANCE AS DT_NAISSANCE,
    CD_LIEU_NAISSANCE AS CD_LIEU_NAISSANCE,
    NM_VILLE AS NM_VILLE,
    NM_PAYS AS NM_PAYS,
    DT_DECES AS DT_DECES,
    CD_LIEU_DECES AS CD_LIEU_DECES,
    NB_ACTE_DECES AS NB_ACTE_DECES,
    CAST(1 AS BOOLEAN) AS FL_ACTIVE,
    NM_FILE AS NM_FILE,
    'insee' AS NM_PROVIDER
FROM deduplicated
WHERE RN = 1;
