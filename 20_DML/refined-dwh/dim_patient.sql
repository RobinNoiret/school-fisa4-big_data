-- REFINED -> DWH | dim_patient

WITH patient_source AS (

    SELECT
        ID_PATIENT,

        CASE
            WHEN CD_SEXE IS NULL OR TRIM(CD_SEXE) = ''
            THEN CAST(NULL AS STRING)
            ELSE UPPER(TRIM(CD_SEXE))
        END AS CD_SEXE,

        DT_NAISSANCE AS NB_ANNEE_NAISSANCE,

        UPPER(TRIM(CD_GROUPE_SANGUIN)) AS CD_GROUPE_SANGUIN,

        UPPER(TRIM(NM_VILLE)) AS NM_COMMUNE,

        CASE
            WHEN CD_DEPARTEMENT IS NULL OR TRIM(CD_DEPARTEMENT) = ''
            THEN CAST(NULL AS STRING)
            ELSE UPPER(TRIM(CD_DEPARTEMENT))
        END AS CD_DEPARTEMENT,

        CASE
            WHEN NM_PAYS IS NULL OR TRIM(NM_PAYS) = ''
            THEN CAST(NULL AS STRING)
            WHEN UPPER(TRIM(NM_PAYS)) IN ('FR', 'FRANCE')
            THEN 'FRANCE'
            ELSE UPPER(TRIM(NM_PAYS))
        END AS NM_PAYS

    FROM chu_refined.soins_system_patient

    WHERE FL_ACTIVE = TRUE
      AND ID_PATIENT IS NOT NULL

),

patient_prepared AS (

    SELECT
        ID_PATIENT,
        CD_SEXE,
        NB_ANNEE_NAISSANCE,
        CD_GROUPE_SANGUIN,
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_PAYS,

        CASE
            WHEN NB_ANNEE_NAISSANCE IS NULL
              OR NB_ANNEE_NAISSANCE > 2021
              OR NB_ANNEE_NAISSANCE < 1900
            THEN CAST(NULL AS STRING)

            WHEN 2021 - NB_ANNEE_NAISSANCE < 18 THEN '00-17'
            WHEN 2021 - NB_ANNEE_NAISSANCE < 30 THEN '18-29'
            WHEN 2021 - NB_ANNEE_NAISSANCE < 45 THEN '30-44'
            WHEN 2021 - NB_ANNEE_NAISSANCE < 60 THEN '45-59'
            WHEN 2021 - NB_ANNEE_NAISSANCE < 75 THEN '60-74'
            ELSE '75-PLUS'
        END AS LB_TRANCHE_AGE

    FROM patient_source

),

localisations_uniques AS (

    SELECT
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_PAYS,

        CASE
            WHEN COUNT(*) = 1 THEN MIN(ID_DIM_LOCALISATION)
            ELSE NULL
        END AS ID_DIM_LOCALISATION

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = 'COMMUNE_NOM'

    GROUP BY
        NM_COMMUNE,
        CD_DEPARTEMENT,
        NM_PAYS

)

INSERT OVERWRITE TABLE chu_dwh.dim_patient

PARTITION (CD_SEXE, LB_TRANCHE_AGE)

SELECT
    CAST(
        ROW_NUMBER() OVER (ORDER BY src.ID_PATIENT)
        AS INT
    ) AS ID_DIM_PATIENT,

    src.ID_PATIENT,
    src.NB_ANNEE_NAISSANCE,
    src.CD_GROUPE_SANGUIN,
    loc.ID_DIM_LOCALISATION AS FK_DIM_LOCALISATION,

    src.CD_SEXE,
    src.LB_TRANCHE_AGE

FROM patient_prepared src

LEFT JOIN localisations_uniques loc
    ON src.NM_COMMUNE = loc.NM_COMMUNE
   AND src.CD_DEPARTEMENT <=> loc.CD_DEPARTEMENT
   AND src.NM_PAYS <=> loc.NM_PAYS;
