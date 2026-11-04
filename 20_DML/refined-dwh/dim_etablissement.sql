-- REFINED -> DWH | dim_etablissement

WITH etablissement_source AS (

    SELECT
        TRIM(ID_ORGANISATION) AS ID_ORGANISATION,
        UPPER(TRIM(CD_SITE)) AS CD_FINESS_SITE,
        UPPER(TRIM(TXT_RAISON_SOCIALE)) AS TXT_RAISON_SOCIALE,
        UPPER(TRIM(NM_ENSEIGNE_COMMERCIALE_SITE)) AS NM_ENSEIGNE,
        UPPER(TRIM(CD_POSTAL)) AS CD_POSTAL,
        UPPER(TRIM(CD_COMMUNE)) AS CD_COMMUNE,
        UPPER(TRIM(NM_PAYS)) AS NM_PAYS

    FROM chu_refined.corporate_system_etablissement

    WHERE FL_ACTIVE = TRUE
      AND ID_ORGANISATION IS NOT NULL
      AND TRIM(ID_ORGANISATION) <> ''

),

localisations_uniques AS (

    SELECT
        CD_COMMUNE,
        NM_PAYS,

        CASE
            WHEN COUNT(*) = 1 THEN MIN(ID_DIM_LOCALISATION)
            ELSE NULL
        END AS ID_DIM_LOCALISATION

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = null
      AND CD_COMMUNE IS NOT NULL
      AND TRIM(CD_COMMUNE) <> ''

    GROUP BY
        CD_COMMUNE,
        NM_PAYS

)

INSERT OVERWRITE TABLE chu_dwh.dim_etablissement

SELECT
    CAST(
        ROW_NUMBER() OVER (ORDER BY src.ID_ORGANISATION)
        AS INT
    ) AS ID_DIM_ETABLISSEMENT,

    src.ID_ORGANISATION,
    src.CD_FINESS_SITE,
    src.TXT_RAISON_SOCIALE,
    src.NM_ENSEIGNE,
    src.CD_POSTAL,
    loc.ID_DIM_LOCALISATION AS FK_DIM_LOCALISATION

FROM etablissement_source src

LEFT JOIN localisations_uniques loc
    ON src.CD_COMMUNE = loc.CD_COMMUNE
   AND src.NM_PAYS <=> loc.NM_PAYS;
