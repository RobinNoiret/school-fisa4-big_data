CREATE TABLE IF NOT EXISTS chu_refined.soins_system_hospitalisation (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    ID_HOSPITALISATION                 INTEGER  COMMENT 'Identifiant hospitalisation',
    ID_PATIENT                         INTEGER  COMMENT 'Identifiant patient',
    ID_ORIGANISATION                   STRING   COMMENT 'Identifiant organisation',
    CD_DIAGNOSTIC                      STRING   COMMENT 'Code diagnostic',
    DESC_DIAGNOSTIC                    STRING   COMMENT 'Description diagnostic',
    DT_ENTREE                          STRING   COMMENT 'Date entree AAAA-MM-JJ',
    NB_JOUR                            INTEGER  COMMENT 'Nombre jour',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_hospitalisation'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/hospitalisations'
;
