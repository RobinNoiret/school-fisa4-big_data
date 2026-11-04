-- REFINED -> DWH | dim_localisation

WITH communes_patients AS (

    SELECT DISTINCT
        null AS CD_NIVEAU_LOCALISATION,
        CAST(NULL AS STRING) AS CD_COMMUNE,
        UPPER(TRIM(NM_VILLE)) AS NM_COMMUNE,
        UPPER(TRIM(CD_DEPARTEMENT)) AS CD_DEPARTEMENT,
        CAST(NULL AS STRING) AS NM_DEPARTEMENT,
        CAST(NULL AS STRING) AS CD_REGION,
        UPPER(TRIM(NM_PAYS)) AS NM_PAYS,
        null AS NM_REGION

    FROM chu_refined.soins_system_patient

    WHERE FL_ACTIVE = TRUE
      AND NM_VILLE IS NOT NULL
      AND TRIM(NM_VILLE) <> ''

),

communes_etablissements AS (

    SELECT DISTINCT
        null AS CD_NIVEAU_LOCALISATION,
        UPPER(TRIM(CD_COMMUNE)) AS CD_COMMUNE,
        UPPER(TRIM(TXT_COMMUNE)) AS NM_COMMUNE,
        CAST(NULL AS STRING) AS CD_DEPARTEMENT,
        CAST(NULL AS STRING) AS NM_DEPARTEMENT,
        CAST(NULL AS STRING) AS CD_REGION,
        UPPER(TRIM(NM_PAYS)) AS NM_PAYS,
        null AS NM_REGION

    FROM chu_refined.corporate_system_etablissement

    WHERE FL_ACTIVE = TRUE
      AND CD_COMMUNE IS NOT NULL
      AND TRIM(CD_COMMUNE) <> ''

),

pays_patients AS (

    SELECT DISTINCT
        null AS CD_NIVEAU_LOCALISATION,
        CAST(NULL AS STRING) AS CD_COMMUNE,
        CAST(NULL AS STRING) AS NM_COMMUNE,
        CAST(NULL AS STRING) AS CD_DEPARTEMENT,
        CAST(NULL AS STRING) AS NM_DEPARTEMENT,
        CAST(NULL AS STRING) AS CD_REGION,
        UPPER(TRIM(NM_PAYS)) AS NM_PAYS,
        null AS NM_REGION

    FROM chu_refined.soins_system_patient

    WHERE FL_ACTIVE = TRUE
      AND NM_PAYS IS NOT NULL
      AND TRIM(NM_PAYS) <> ''

),

localisations_source AS (

    SELECT * FROM communes_patients

    UNION ALL

    SELECT * FROM communes_etablissements

    UNION ALL

    SELECT * FROM pays_patients

),

localisations_distinctes AS (

    SELECT DISTINCT
        CD_NIVEAU_LOCALISATION,
        CD_COMMUNE,
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_DEPARTEMENT,
        CD_REGION,
        NM_PAYS,
        NM_REGION

    FROM localisations_source

)

INSERT OVERWRITE TABLE chu_dwh.dim_localisation

PARTITION (NM_REGION)

SELECT
    CAST(
        ROW_NUMBER() OVER (
            ORDER BY
                CD_NIVEAU_LOCALISATION,
                NM_PAYS,
                CD_DEPARTEMENT,
                CD_COMMUNE,
                NM_COMMUNE
        )
        AS INT
    ) AS ID_DIM_LOCALISATION,

    CD_NIVEAU_LOCALISATION,
    CD_COMMUNE,
    NM_COMMUNE,
    CD_DEPARTEMENT,
    NM_DEPARTEMENT,
    CD_REGION,
    NM_PAYS,
    NM_REGION

FROM localisations_distinctes;
