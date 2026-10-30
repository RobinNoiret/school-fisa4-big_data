CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_specialites (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    CD_SPECIALITE                      STRING   COMMENT 'Code specialite',
    NM_FONCTION                        STRING   COMMENT 'Nom fonction',
    NM_SPECIALITE                      STRING   COMMENT 'Nom specialite',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_specialites'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/specialites'

;
