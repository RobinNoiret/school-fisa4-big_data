-- REFINED -> DWH | dim_professionnel

WITH professionnel_source AS (

    SELECT
        TRIM(ID_PROFESSIONNEL) AS ID_PROFESSIONNEL,
        UPPER(TRIM(TXT_CIVILITE)) AS TXT_CIVILITE,
        UPPER(TRIM(TXT_CATEGORIE_PRO)) AS TXT_CATEGORIE_PRO,
        UPPER(TRIM(TXT_PROFESSION)) AS TXT_PROFESSION,
        UPPER(TRIM(TXT_MODE_EXERCICE)) AS TXT_MODE_EXERCICE,
        UPPER(TRIM(CD_SPECIALITE)) AS CD_SPECIALITE,
        TRIM(ID_ORGANISATION) AS ID_ORGANISATION

    FROM chu_refined.corporate_system_professionnel_sante

    WHERE FL_ACTIVE = TRUE
      AND ID_PROFESSIONNEL IS NOT NULL
      AND TRIM(ID_PROFESSIONNEL) <> ''

),

etablissements_uniques AS (

    SELECT
        ID_ORGANISATION,

        CASE
            WHEN COUNT(*) = 1 THEN MIN(ID_DIM_ETABLISSEMENT)
            ELSE NULL
        END AS ID_DIM_ETABLISSEMENT

    FROM chu_dwh.dim_etablissement

    GROUP BY ID_ORGANISATION

)

INSERT OVERWRITE TABLE chu_dwh.dim_professionnel

SELECT
    CAST(
        ROW_NUMBER() OVER (ORDER BY src.ID_PROFESSIONNEL)
        AS INT
    ) AS ID_DIM_PROFESSIONNEL,

    src.ID_PROFESSIONNEL,
    src.TXT_CIVILITE,
    src.TXT_CATEGORIE_PRO,
    src.TXT_PROFESSION,
    src.TXT_MODE_EXERCICE,
    specialite.ID_DIM_SPECIALITE AS FK_DIM_SPECIALITE,
    etablissement.ID_DIM_ETABLISSEMENT AS FK_DIM_ETABLISSEMENT

FROM professionnel_source src

LEFT JOIN chu_dwh.dim_specialite specialite
    ON specialite.CD_SPECIALITE = src.CD_SPECIALITE

LEFT JOIN etablissements_uniques etablissement
    ON etablissement.ID_ORGANISATION = src.ID_ORGANISATION;
