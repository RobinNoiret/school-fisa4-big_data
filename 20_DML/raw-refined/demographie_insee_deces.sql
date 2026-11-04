-- RAW -> REFINED | demographie_insee_deces



WITH source_raw AS (
    SELECT
        ID_TECH,
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
),

prepared AS (
    SELECT
        ID_TECH,
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
)

INSERT OVERWRITE TABLE chu_refined.demographie_insee_deces
PARTITION (DT_DECES)

SELECT
    ID_TECH,
    NM_SEXE,
    DT_NAISSANCE,
    CD_LIEU_NAISSANCE,
    NM_VILLE,
    NM_PAYS,
    CD_LIEU_DECES,
    NB_ACTE_DECES,
    CAST(1 AS BOOLEAN) AS FL_ACTIVE,
    NM_FILE,
    'insee' AS NM_PROVIDER,
    DT_DECES

FROM prepared
DISTRIBUTE BY DT_DECES;
