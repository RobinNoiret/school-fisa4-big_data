-- REFINED -> DWH | dim_etablissement

WITH etablissement_source AS (
    SELECT TRIM(ID_ORGANISATION) AS ID_ORGANISATION,
           UPPER(TRIM(CD_SITE)) AS CD_FINESS_SITE,
           UPPER(TRIM(TXT_RAISON_SOCIALE)) AS TXT_RAISON_SOCIALE,
           UPPER(TRIM(NM_ENSEIGNE_COMMERCIALE_SITE)) AS NM_ENSEIGNE,
           UPPER(TRIM(CD_POSTAL)) AS CD_POSTAL,
           UPPER(TRIM(TXT_COMMUNE)) AS NM_VILLE
    FROM chu_refined.corporate_system_etablissement
    WHERE FL_ACTIVE = TRUE AND ID_ORGANISATION IS NOT NULL AND TRIM(ID_ORGANISATION) <> ''
),

ville_etablissement AS (
    SELECT NM_VILLE,
           MIN(ID_DIM_VILLE) AS ID_DIM_VILLE
    FROM chu_dwh.dim_ville
    GROUP BY NM_VILLE
)

INSERT OVERWRITE TABLE chu_dwh.dim_etablissement (
    ID_DIM_ETABLISSEMENT,
    ID_ORGANISATION,
    CD_FINESS_SITE,
    TXT_RAISON_SOCIALE,
    NM_ENSEIGNE,
    CD_POSTAL,
    FK_DIM_VILLE
)

SELECT ROW_NUMBER() OVER (ORDER BY src.ID_ORGANISATION),
       src.ID_ORGANISATION,
       src.CD_FINESS_SITE,
       src.TXT_RAISON_SOCIALE,
       src.NM_ENSEIGNE,
       src.CD_POSTAL,
       ville.ID_DIM_VILLE
    FROM etablissement_source src
LEFT JOIN ville_etablissement ville ON ville.NM_VILLE = src.NM_VILLE;
