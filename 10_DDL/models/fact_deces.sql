CREATE TABLE IF NOT EXISTS chu_dwh.fact_deces (

    ID_FAIT_DECES BIGINT
        COMMENT 'Cle technique du deces dans le chargement',

    FK_DIM_LOCALISATION_DECES INT
        COMMENT 'Localisation du deces',

    FK_DIM_LOCALISATION_NAISSANCE INT
        COMMENT 'Localisation de naissance si connue',

    CD_SEXE STRING,

    NB_AGE_DECES INT
        COMMENT 'Age estime au deces'

)

COMMENT 'Fait : une ligne par deces source'

PARTITIONED BY (

    NB_ANNEE_DECES INT

)

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_deces';
