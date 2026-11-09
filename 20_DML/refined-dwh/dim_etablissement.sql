-- REFINED -> DWH | dim_etablissement

WITH etablissement_source AS (

    SELECT
        TRIM(ID_ORGANISATION) AS ID_ORGANISATION,

        UPPER(TRIM(CD_SITE)) AS CD_FINESS_SITE,

        UPPER(TRIM(TXT_RAISON_SOCIALE)) AS TXT_RAISON_SOCIALE,

        UPPER(TRIM(NM_ENSEIGNE_COMMERCIALE_SITE)) AS NM_ENSEIGNE,

        TRIM(CD_POSTAL) AS CD_POSTAL,

        UPPER(TRIM(CD_COMMUNE)) AS CD_COMMUNE,

        CASE
            WHEN NM_PAYS IS NULL OR TRIM(NM_PAYS) = ''
            THEN CAST(NULL AS STRING)

            WHEN UPPER(TRIM(NM_PAYS)) IN ('FR', 'FRANCE')
            THEN 'FRANCE'

            ELSE UPPER(TRIM(NM_PAYS))
        END AS NM_PAYS

    FROM chu_refined.corporate_system_etablissement

    WHERE FL_ACTIVE = TRUE
      AND ID_ORGANISATION IS NOT NULL
      AND TRIM(ID_ORGANISATION) <> ''

),

etablissement_prepare AS (

    SELECT
        ID_ORGANISATION,
        CD_FINESS_SITE,
        TXT_RAISON_SOCIALE,
        NM_ENSEIGNE,
        CD_POSTAL,
        CD_COMMUNE,
        NM_PAYS,

        CASE
            WHEN NM_PAYS IS NULL OR NM_PAYS <> 'FRANCE'
            THEN CAST(NULL AS STRING)

            WHEN CD_POSTAL IS NULL
              OR NOT (CD_POSTAL RLIKE '^[0-9]{5}$')
            THEN CAST(NULL AS STRING)

            WHEN SUBSTR(CD_POSTAL, 1, 2) = '20'
            THEN 'CORSE'

            WHEN SUBSTR(CD_POSTAL, 1, 3) = '971'
            THEN 'GUADELOUPE'

            WHEN SUBSTR(CD_POSTAL, 1, 3) = '972'
            THEN 'MARTINIQUE'

            WHEN SUBSTR(CD_POSTAL, 1, 3) = '973'
            THEN 'GUYANE'

            WHEN SUBSTR(CD_POSTAL, 1, 3) = '974'
            THEN 'LA REUNION'

            WHEN SUBSTR(CD_POSTAL, 1, 3) = '976'
            THEN 'MAYOTTE'

            WHEN SUBSTR(CD_POSTAL, 1, 2) IN ('97', '98')
            THEN CAST(NULL AS STRING)

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('01','03','07','15','26','38','42','43','63','69','73','74')
            THEN 'AUVERGNE-RHONE-ALPES'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('21','25','39','58','70','71','89','90')
            THEN 'BOURGOGNE-FRANCHE-COMTE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('22','29','35','56')
            THEN 'BRETAGNE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('18','28','36','37','41','45')
            THEN 'CENTRE-VAL DE LOIRE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('08','10','51','52','54','55','57','67','68','88')
            THEN 'GRAND EST'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('02','59','60','62','80')
            THEN 'HAUTS-DE-FRANCE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('75','77','78','91','92','93','94','95')
            THEN 'ILE-DE-FRANCE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('14','27','50','61','76')
            THEN 'NORMANDIE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('16','17','19','23','24','33','40','47','64','79','86','87')
            THEN 'NOUVELLE-AQUITAINE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('09','11','12','30','31','32','34','46','48','65','66','81','82')
            THEN 'OCCITANIE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('44','49','53','72','85')
            THEN 'PAYS DE LA LOIRE'

            WHEN SUBSTR(CD_POSTAL, 1, 2)
                 IN ('04','05','06','13','83','84')
            THEN 'PROVENCE-ALPES-COTE D AZUR'

            ELSE CAST(NULL AS STRING)
        END AS NM_REGION_POSTALE

    FROM etablissement_source

),

localisations_commune AS (

    SELECT
        CD_COMMUNE,

        CASE
            WHEN COUNT(*) = 1
            THEN MIN(ID_DIM_LOCALISATION)
            ELSE NULL
        END AS ID_DIM_LOCALISATION

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = 'COMMUNE_CODE'
      AND CD_COMMUNE IS NOT NULL
      AND TRIM(CD_COMMUNE) <> ''
      AND CD_COMMUNE <> '00000'

    GROUP BY CD_COMMUNE

),

localisations_region AS (

    SELECT
        NM_REGION,

        CASE
            WHEN COUNT(*) = 1
            THEN MIN(ID_DIM_LOCALISATION)
            ELSE NULL
        END AS ID_DIM_LOCALISATION

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = 'REGION_POSTALE'

    GROUP BY NM_REGION

)

INSERT OVERWRITE TABLE chu_dwh.dim_etablissement

SELECT
    CAST(

        ROW_NUMBER() OVER (
            ORDER BY src.ID_ORGANISATION
        )

        AS INT

    ) AS ID_DIM_ETABLISSEMENT,

    src.ID_ORGANISATION,
    src.CD_FINESS_SITE,
    src.TXT_RAISON_SOCIALE,
    src.NM_ENSEIGNE,
    src.CD_POSTAL,

    -- Priorite au code commune, puis region du code postal
    COALESCE(

        commune.ID_DIM_LOCALISATION,

        region_postale.ID_DIM_LOCALISATION

    ) AS FK_DIM_LOCALISATION

FROM etablissement_prepare src

LEFT JOIN localisations_commune commune
    ON src.CD_COMMUNE = commune.CD_COMMUNE

LEFT JOIN localisations_region region_postale
    ON src.NM_REGION_POSTALE = region_postale.NM_REGION;
