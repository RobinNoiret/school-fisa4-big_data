CREATE TABLE IF NOT EXISTS chu_dwh.dim_patient (

    ID_DIM_PATIENT INT
        COMMENT 'Cle de substitution du patient. [PK logique]',

    ID_PATIENT INT
        COMMENT 'Identifiant pseudonymise du patient.',

    NB_ANNEE_NAISSANCE INT
        COMMENT 'Annee de naissance du patient.',

    CD_GROUPE_SANGUIN STRING
        COMMENT 'Code groupe sanguin.',

    FK_DIM_LOCALISATION INT
        COMMENT 'Localisation de residence. [FK DIM_LOCALISATION]'

)

COMMENT 'Dimension patient partitionnee par sexe et tranche d age'

PARTITIONED BY (

    CD_SEXE STRING
        COMMENT 'Code sexe du patient.',

    LB_TRANCHE_AGE STRING
        COMMENT 'Tranche d age calculee selon la date de reference du chargement.'

)

CLUSTERED BY (ID_PATIENT)
INTO 4 BUCKETS

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_patient';
