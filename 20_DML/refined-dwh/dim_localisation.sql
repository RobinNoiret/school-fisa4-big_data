WITH etablissements_source AS (

    SELECT
        TRIM(CD_POSTAL) AS CD_POSTAL,

        CASE
            WHEN UPPER(TRIM(NM_PAYS)) IN ('FR', 'FRANCE')
            THEN 'FRANCE'

            ELSE UPPER(TRIM(NM_PAYS))
        END AS NM_PAYS

    FROM chu_refined.corporate_system_etablissement

    WHERE FL_ACTIVE = TRUE
      AND ID_ORGANISATION IS NOT NULL
      AND TRIM(ID_ORGANISATION) <> ''

),

codes_postaux AS (

    SELECT
        CD_POSTAL,
        NM_PAYS,

        CASE
            WHEN NM_PAYS <> 'FRANCE'
              OR NM_PAYS IS NULL
            THEN CAST(NULL AS STRING)

            WHEN CD_POSTAL IS NULL
              OR NOT (CD_POSTAL RLIKE '^[0-9]{5}$')
            THEN CAST(NULL AS STRING)

            -- Corse : on ne cherche pas ici a distinguer 2A et 2B
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

            -- Autres codes d'outre-mer : pas de deduction ici
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
        END AS NM_REGION

    FROM etablissements_source

),

regions_source AS (

    SELECT DISTINCT
        NM_REGION

    FROM codes_postaux

    WHERE NM_REGION IS NOT NULL

),

regions_existantes AS (

    SELECT
        NM_REGION,
        COUNT(*) AS NB_LIGNES

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = 'REGION_POSTALE'

    GROUP BY NM_REGION

),

regions_manquantes AS (

    SELECT
        src.NM_REGION

    FROM regions_source src

    LEFT JOIN regions_existantes existante
        ON src.NM_REGION = existante.NM_REGION

    WHERE existante.NB_LIGNES IS NULL

),

cle_max AS (

    SELECT
        COALESCE(MAX(ID_DIM_LOCALISATION), 0) AS ID_MAX

    FROM chu_dwh.dim_localisation

),

nouvelles_regions AS (

    SELECT
        cle_max.ID_MAX
            + ROW_NUMBER() OVER (ORDER BY regions.NM_REGION)
            AS ID_DIM_LOCALISATION,

        regions.NM_REGION

    FROM regions_manquantes regions

    CROSS JOIN cle_max

)

INSERT INTO TABLE chu_dwh.dim_localisation

PARTITION (NM_REGION)

SELECT
    CAST(ID_DIM_LOCALISATION AS INT) AS ID_DIM_LOCALISATION,

    'REGION_POSTALE' AS CD_NIVEAU_LOCALISATION,

    CAST(NULL AS STRING) AS CD_COMMUNE,

    CAST(NULL AS STRING) AS NM_COMMUNE,

    CAST(NULL AS STRING) AS CD_DEPARTEMENT,

    'FRANCE' AS NM_PAYS,

    NM_REGION

FROM nouvelles_regions;
