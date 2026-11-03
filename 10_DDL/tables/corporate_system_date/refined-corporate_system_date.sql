CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_date (

    ID_TECH  INT  COMMENT 'Identifiant technique',
    DT_DEBUT DATE COMMENT 'Date debut',
    DT_FIN   DATE COMMENT 'Date fin',

    -- Champs techniques
    FL_ACTIVE   BOOLEAN COMMENT 'Ligne active',
    NM_FILE     STRING  COMMENT 'Fichier source',
    NM_PROVIDER STRING  COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_date'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/date';
