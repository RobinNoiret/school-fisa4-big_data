CREATE TABLE IF NOT EXISTS chu_dwh.fact_deces (

    ID_FAIT_DECES INT
        COMMENT 'Cle de substitution du deces. [PK logique]',

    FK_DIM_LOCALISATION_DECES INT
        COMMENT 'Lieu du deces. [FK DIM_LOCALISATION]',

    FK_DIM_LOCALISATION_NAISSANCE INT
        COMMENT 'Pays de naissance si connu. [FK DIM_LOCALISATION]',

    CD_SEXE STRING
        COMMENT 'Code sexe.',

    NB_AGE_DECES INT
        COMMENT 'Age estime au deces en annees.'

)

COMMENT 'Fait : une ligne par deces source'

PARTITIONED BY (

    NB_ANNEE_DECES INT
        COMMENT 'Annee du deces.'

)

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_deces';
