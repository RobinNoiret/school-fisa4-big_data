CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_date (

    ID_TECH        INT   COMMENT 'Identifiant technique',
    DT_DEBUT       DATE      COMMENT 'Date debut',
    DT_FIN         DATE      COMMENT 'Date fin',
    
    -- champs techniques
    fl_active      BOOLEAN  COMMENT 'Ligne active',
    nm_file        STRING   COMMENT 'Fichier source',
    nm_provider    STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_date'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/date'
;
