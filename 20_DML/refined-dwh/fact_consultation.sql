-- REFINED -> DWH | fact_consultation

WITH consultation_source AS (

    SELECT
        ID_CONSULTATION,

        ID_MUTUELLE,

        ID_PATIENT,

        TRIM(ID_PROFESSIONNEL_SANTE) AS ID_PROFESSIONNEL,

        UPPER(TRIM(CD_DIAGNOSTIC)) AS CD_DIAGNOSTIC,

        DT_CONSULTATION,

        TRIM(TS_DEBUT) AS TS_DEBUT,

        TRIM(TS_FIN) AS TS_FIN

    FROM chu_refined.soins_system_consultation

    WHERE FL_ACTIVE = TRUE
      AND ID_CONSULTATION IS NOT NULL
      AND DT_CONSULTATION IS NOT NULL

),

consultation_prepared AS (

    SELECT
        ID_CONSULTATION,
        ID_MUTUELLE,
        ID_PATIENT,
        ID_PROFESSIONNEL,
        CD_DIAGNOSTIC,
        DT_CONSULTATION,

        COALESCE(

            UNIX_TIMESTAMP(
                CONCAT(
                    CAST(DT_CONSULTATION AS STRING),
                    ' ',
                    TS_DEBUT
                ),
                'yyyy-MM-dd HH:mm:ss'
            ),

            UNIX_TIMESTAMP(
                CONCAT(
                    CAST(DT_CONSULTATION AS STRING),
                    ' ',
                    TS_DEBUT
                ),
                'yyyy-MM-dd HH:mm'
            )

        ) AS TS_DEBUT_SECONDS,

        COALESCE(

            UNIX_TIMESTAMP(
                CONCAT(
                    CAST(DT_CONSULTATION AS STRING),
                    ' ',
                    TS_FIN
                ),
                'yyyy-MM-dd HH:mm:ss'
            ),

            UNIX_TIMESTAMP(
                CONCAT(
                    CAST(DT_CONSULTATION AS STRING),
                    ' ',
                    TS_FIN
                ),
                'yyyy-MM-dd HH:mm'
            )

        ) AS TS_FIN_SECONDS

    FROM consultation_source

)

INSERT OVERWRITE TABLE chu_dwh.fact_consultation

PARTITION (NB_ANNEE_CONSULTATION)

SELECT
    src.ID_CONSULTATION,

    temps.ID_DIM_TEMPS AS FK_DIM_TEMPS,

    patient.ID_DIM_PATIENT AS FK_DIM_PATIENT,

    professionnel.ID_DIM_PROFESSIONNEL AS FK_DIM_PROFESSIONNEL,

    -- Etablissement principal du professionnel
    professionnel.FK_DIM_ETABLISSEMENT AS FK_DIM_ETABLISSEMENT,

    diagnostic.ID_DIM_DIAGNOSTIC AS FK_DIM_DIAGNOSTIC,

    mutuelle.ID_DIM_MUTUELLE AS FK_DIM_MUTUELLE,

    CASE
        WHEN patient.NB_ANNEE_NAISSANCE IS NOT NULL
         AND patient.NB_ANNEE_NAISSANCE <= YEAR(src.DT_CONSULTATION)

        THEN YEAR(src.DT_CONSULTATION)
             - patient.NB_ANNEE_NAISSANCE

        ELSE NULL
    END AS NB_AGE_PATIENT,

    CASE
        WHEN src.TS_DEBUT_SECONDS IS NOT NULL
         AND src.TS_FIN_SECONDS IS NOT NULL
         AND src.TS_FIN_SECONDS >= src.TS_DEBUT_SECONDS

        THEN CAST(

            (src.TS_FIN_SECONDS - src.TS_DEBUT_SECONDS) / 60

            AS INT

        )

        ELSE NULL
    END AS DUR_CONSULTATION_MIN,

    -- Colonne de partition dynamique en derniere position
    YEAR(src.DT_CONSULTATION) AS NB_ANNEE_CONSULTATION

FROM consultation_prepared src

LEFT JOIN chu_dwh.dim_temps temps
    ON temps.DT_JOUR = src.DT_CONSULTATION

LEFT JOIN chu_dwh.dim_patient patient
    ON patient.ID_PATIENT = src.ID_PATIENT

LEFT JOIN chu_dwh.dim_professionnel professionnel
    ON professionnel.ID_PROFESSIONNEL = src.ID_PROFESSIONNEL

LEFT JOIN chu_dwh.dim_diagnostic diagnostic
    ON diagnostic.CD_DIAGNOSTIC = src.CD_DIAGNOSTIC

LEFT JOIN chu_dwh.dim_mutuelle mutuelle
    ON mutuelle.ID_MUTUELLE = src.ID_MUTUELLE;
