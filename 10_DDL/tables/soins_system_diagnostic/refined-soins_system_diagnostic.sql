CREATE TABLE IF NOT EXISTS chu_refined.soins_system_diagnostic (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    CD_DIAGNOSTIC                      STRING   COMMENT 'Code diagnostic',
    NM_DIAGNOSTIC                      STRING   COMMENT 'Nom diagnostic',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_diagnostic'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/diagnostic'
;
