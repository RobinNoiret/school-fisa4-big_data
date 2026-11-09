CREATE TABLE IF NOT EXISTS chu_dwh.dim_localisation (

    ID_DIM_LOCALISATION INT
        COMMENT 'Cle de substitution de la localisation',

    CD_NIVEAU_LOCALISATION STRING
        COMMENT 'Niveau de localisation : COMMUNE, DEPARTEMENT ou PAYS',

    CD_COMMUNE STRING
        COMMENT 'Code commune INSEE si disponible',

    NM_COMMUNE STRING
        COMMENT 'Nom commune si disponible',

    CD_DEPARTEMENT STRING
        COMMENT 'Code departement si disponible',

    NM_PAYS STRING
        COMMENT 'Nom pays normalise'

)

COMMENT 'Dimension localisation'

PARTITIONED BY (

    NM_REGION STRING
        COMMENT 'Region deduite si possible'

)

CLUSTERED BY (ID_DIM_LOCALISATION)
INTO 4 BUCKETS

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_localisation';
