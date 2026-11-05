-- REFINED -> DWH | dim_localisation

WITH communes_patients AS (

    SELECT DISTINCT
        'COMMUNE' AS CD_NIVEAU_LOCALISATION,
        CAST(NULL AS STRING) AS CD_COMMUNE,
        UPPER(TRIM(NM_VILLE)) AS NM_COMMUNE,
        CASE
            WHEN CD_DEPARTEMENT IS NULL
              OR TRIM(CD_DEPARTEMENT) = ''
            THEN CAST(NULL AS STRING)
            ELSE UPPER(TRIM(CD_DEPARTEMENT))
        END AS CD_DEPARTEMENT,
        CAST(NULL AS STRING) AS NM_DEPARTEMENT,
        CAST(NULL AS STRING) AS CD_REGION,
        CASE
            WHEN NM_PAYS IS NULL
              OR TRIM(NM_PAYS) = ''
            THEN CAST(NULL AS STRING)
            WHEN UPPER(TRIM(NM_PAYS)) IN ('FR', 'FRANCE')
            THEN 'FRANCE'
            ELSE UPPER(TRIM(NM_PAYS))
        END AS NM_PAYS,
        NULL AS NM_REGION

    FROM chu_refined.soins_system_patient

    WHERE FL_ACTIVE = TRUE
      AND NM_VILLE IS NOT NULL
      AND TRIM(NM_VILLE) <> ''

),

communes_etablissements AS (

    SELECT DISTINCT
        'COMMUNE' AS CD_NIVEAU_LOCALISATION,
        UPPER(TRIM(CD_COMMUNE)) AS CD_COMMUNE,
        CASE
            WHEN TXT_COMMUNE IS NULL
              OR TRIM(TXT_COMMUNE) = ''
            THEN CAST(NULL AS STRING)
            WHEN TRIM(TXT_COMMUNE) RLIKE '^[0-9]+$'
            THEN CAST(NULL AS STRING)
            ELSE UPPER(TRIM(TXT_COMMUNE))
        END AS NM_COMMUNE,
        CAST(NULL AS STRING) AS CD_DEPARTEMENT,
        CAST(NULL AS STRING) AS NM_DEPARTEMENT,
        CAST(NULL AS STRING) AS CD_REGION,
        CASE
            WHEN NM_PAYS IS NULL
              OR TRIM(NM_PAYS) = ''
            THEN CAST(NULL AS STRING)
            WHEN UPPER(TRIM(NM_PAYS)) IN ('FR', 'FRANCE')
            THEN 'FRANCE'
            ELSE UPPER(TRIM(NM_PAYS))
        END AS NM_PAYS,
        NULL AS NM_REGION

    FROM chu_refined.corporate_system_etablissement

    WHERE FL_ACTIVE = TRUE
      AND CD_COMMUNE IS NOT NULL
      AND TRIM(CD_COMMUNE) <> ''

),

pays_patients AS (

    SELECT DISTINCT
        'PAYS' AS CD_NIVEAU_LOCALISATION,
        CAST(NULL AS STRING) AS CD_COMMUNE,
        CAST(NULL AS STRING) AS NM_COMMUNE,
        CAST(NULL AS STRING) AS CD_DEPARTEMENT,
        CAST(NULL AS STRING) AS NM_DEPARTEMENT,
        CAST(NULL AS STRING) AS CD_REGION,
        CASE
            WHEN UPPER(TRIM(NM_PAYS)) IN ('FR', 'FRANCE')
            THEN 'FRANCE'
            ELSE UPPER(TRIM(NM_PAYS))
        END AS NM_PAYS,
        NULL AS NM_REGION

    FROM chu_refined.soins_system_patient

    WHERE FL_ACTIVE = TRUE
      AND NM_PAYS IS NOT NULL
      AND TRIM(NM_PAYS) <> ''

),

localisations_source AS (

    SELECT
        CD_NIVEAU_LOCALISATION,
        CD_COMMUNE,
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_DEPARTEMENT,
        CD_REGION,
        NM_PAYS,
        NM_REGION

    FROM communes_patients

    UNION ALL

    SELECT
        CD_NIVEAU_LOCALISATION,
        CD_COMMUNE,
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_DEPARTEMENT,
        CD_REGION,
        NM_PAYS,
        NM_REGION

    FROM communes_etablissements

    UNION ALL

    SELECT
        CD_NIVEAU_LOCALISATION,
        CD_COMMUNE,
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_DEPARTEMENT,
        CD_REGION,
        NM_PAYS,
        NM_REGION

    FROM pays_patients

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
