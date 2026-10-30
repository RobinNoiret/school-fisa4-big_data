CREATE TABLE IF NOT EXISTS chu_refined.soins_system_prescription (

    ID_CONSULTATION                    INT      COMMENT 'Identifiant consultation',
    CD_CIS                             STRING   COMMENT 'Code CIS',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_prescription'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/prescription'
;
