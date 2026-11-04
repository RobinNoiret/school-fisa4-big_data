CREATE TABLE IF NOT EXISTS chu_dwh.dim_localisation (

    ID_DIM_LOCALISATION INT
        COMMENT 'Cle de substitution de la localisation. [PK logique]',

    CD_NIVEAU_LOCALISATION STRING
        COMMENT 'Niveau : COMMUNE, PAYS ou INCONNUE.',

    CD_COMMUNE STRING
        COMMENT 'Code commune, notamment code INSEE pour la France.',

    NM_COMMUNE STRING
        COMMENT 'Nom de la commune.',

    CD_DEPARTEMENT STRING
        COMMENT 'Code departement.',

    NM_DEPARTEMENT STRING
        COMMENT 'Nom du departement.',

    CD_REGION STRING
        COMMENT 'Code region.',

    NM_PAYS STRING
        COMMENT 'Nom du pays.'

)

COMMENT 'Dimension localisation partitionnee par region'

PARTITIONED BY (

    NM_REGION STRING
        COMMENT 'Nom de la region.'

)

CLUSTERED BY (ID_DIM_LOCALISATION)
INTO 4 BUCKETS

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_localisation';
