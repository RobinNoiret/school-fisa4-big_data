SET hive.optimize.sort.dynamic.partition=true;

-- REFINED -> DWH | fact_deces

WITH deces_source AS (

    SELECT
        ID_TECH,

        UPPER(TRIM(CD_LIEU_DECES)) AS CD_LIEU_DECES,

        TRIM(CAST(NM_SEXE AS STRING)) AS CD_SEXE_SOURCE,

        DT_NAISSANCE,

        DT_DECES

    FROM chu_refined.demographie_insee_deces

    WHERE FL_ACTIVE = TRUE

),

deces_prepared AS (

    SELECT
        ID_TECH,

        CD_LIEU_DECES,

        CASE CD_SEXE_SOURCE
            WHEN '1' THEN 'M'
            WHEN '2' THEN 'F'
            ELSE CD_SEXE_SOURCE
        END AS CD_SEXE,

        DT_DECES AS NB_ANNEE_DECES,

        -- Différence entre deux années :
        -- ce n'est pas nécessairement l'âge exact au décès.
        CASE
            WHEN DT_NAISSANCE IS NOT NULL
             AND DT_DECES IS NOT NULL
             AND DT_DECES >= DT_NAISSANCE

            THEN DT_DECES - DT_NAISSANCE

            ELSE NULL
        END AS NB_AGE_DECES,

        CASE
            -- Un code commune INSEE français contient
            -- 5 caractères, avec éventuellement 2A ou 2B.
            WHEN CD_LIEU_DECES IS NULL
              OR NOT (
                  CD_LIEU_DECES RLIKE '^[0-9]{5}$'
                  OR CD_LIEU_DECES RLIKE '^2[AB][0-9]{3}$'
              )
            THEN CAST(NULL AS STRING)

            -- Corse
            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('2A', '2B', '20')
            THEN 'CORSE'

            -- Départements et régions d'outre-mer
            WHEN SUBSTR(CD_LIEU_DECES, 1, 3) = '971'
            THEN 'GUADELOUPE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 3) = '972'
            THEN 'MARTINIQUE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 3) = '973'
            THEN 'GUYANE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 3) = '974'
            THEN 'LA REUNION'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 3) = '976'
            THEN 'MAYOTTE'

            -- Autres territoires d'outre-mer : non déduits
            WHEN SUBSTR(CD_LIEU_DECES, 1, 2) IN ('97', '98')
            THEN CAST(NULL AS STRING)

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('01', '03', '07', '15', '26', '38',
                     '42', '43', '63', '69', '73', '74')
            THEN 'AUVERGNE-RHONE-ALPES'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('21', '25', '39', '58', '70', '71', '89', '90')
            THEN 'BOURGOGNE-FRANCHE-COMTE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('22', '29', '35', '56')
            THEN 'BRETAGNE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('18', '28', '36', '37', '41', '45')
            THEN 'CENTRE-VAL DE LOIRE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('08', '10', '51', '52', '54',
                     '55', '57', '67', '68', '88')
            THEN 'GRAND EST'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('02', '59', '60', '62', '80')
            THEN 'HAUTS-DE-FRANCE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('75', '77', '78', '91', '92', '93', '94', '95')
            THEN 'ILE-DE-FRANCE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('14', '27', '50', '61', '76')
            THEN 'NORMANDIE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('16', '17', '19', '23', '24', '33',
                     '40', '47', '64', '79', '86', '87')
            THEN 'NOUVELLE-AQUITAINE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('09', '11', '12', '30', '31', '32', '34',
                     '46', '48', '65', '66', '81', '82')
            THEN 'OCCITANIE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('44', '49', '53', '72', '85')
            THEN 'PAYS DE LA LOIRE'

            WHEN SUBSTR(CD_LIEU_DECES, 1, 2)
                 IN ('04', '05', '06', '13', '83', '84')
            THEN 'PROVENCE-ALPES-COTE D AZUR'

            ELSE CAST(NULL AS STRING)

        END AS NM_REGION_DECES

    FROM deces_source

),

regions_uniques AS (

    SELECT
        UPPER(TRIM(NM_REGION)) AS NM_REGION,

        -- Une région dupliquée ne doit pas multiplier les faits.
        CASE
            WHEN COUNT(*) = 1
            THEN MIN(ID_DIM_LOCALISATION)
            ELSE NULL
        END AS ID_DIM_LOCALISATION

    FROM chu_dwh.dim_localisation

    WHERE CD_NIVEAU_LOCALISATION = 'REGION_POSTALE'
      AND NM_REGION IS NOT NULL
      AND TRIM(NM_REGION) <> ''

    GROUP BY UPPER(TRIM(NM_REGION))

)

INSERT OVERWRITE TABLE chu_dwh.fact_deces

PARTITION (NB_ANNEE_DECES)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY src.ID_TECH
    ) AS ID_FAIT_DECES,

    region.ID_DIM_LOCALISATION AS FK_DIM_LOCALISATION_DECES,

    -- La localisation de naissance n'est pas alimentée ici.
    CAST(NULL AS INT) AS FK_DIM_LOCALISATION_NAISSANCE,

    src.CD_SEXE,

    src.NB_AGE_DECES,

    -- Colonne de partition dynamique en dernière position
    src.NB_ANNEE_DECES

FROM deces_prepared src

LEFT JOIN regions_uniques region
    ON src.NM_REGION_DECES = region.NM_REGION;
