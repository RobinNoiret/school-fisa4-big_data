CREATE TABLE IF NOT EXISTS chu_dwh.dim_patient (

    ID_DIM_PATIENT INT
        COMMENT 'Cle de substitution du patient',

    ID_PATIENT INT
        COMMENT 'Identifiant pseudonymise du patient',

    NB_ANNEE_NAISSANCE INT
        COMMENT 'Annee de naissance',

    CD_GROUPE_SANGUIN STRING
        COMMENT 'Code groupe sanguin',

    FK_DIM_LOCALISATION INT
        COMMENT 'Localisation du patient'

)

COMMENT 'Dimension patient'

PARTITIONED BY (

    CD_SEXE STRING
        COMMENT 'Code sexe',

    LB_TRANCHE_AGE STRING
        COMMENT 'Tranche d age a la date de reference'

)

CLUSTERED BY (ID_PATIENT)
INTO 4 BUCKETS

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_patient';
