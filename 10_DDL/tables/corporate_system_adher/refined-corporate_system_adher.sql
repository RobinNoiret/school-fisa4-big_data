CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_adher (

    ID_PATIENT      INT         COMMENT 'Identifiant patient',

    FL_ACTIVE       BOOLEAN     COMMENT 'Ligne active',
    NM_FILE         STRING      COMMENT 'Fichier source',
    NM_PROVIDER     STRING      COMMENT 'Systeme source'
)

COMMENT 'Table interne REFINED corporate_system_adher'

PARTITIONED BY (
    ID_MUTUELLE     INT         COMMENT 'Identifiant mutuelle'
)

CLUSTERED BY (ID_PATIENT)
INTO 4 BUCKETS

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/adher'
;
