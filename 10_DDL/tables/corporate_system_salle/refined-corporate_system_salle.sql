CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_salle (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    ID_SALLE                           STRING   COMMENT 'Identifiant salle',
    ID_CONSULTATION                    INTEGER  COMMENT 'Identifiant consultation',
    CD_BLOC                            STRING   COMMENT 'Code bloc',
    NB_ETAGE                           STRING   COMMENT 'Numéro etage',
    NB_SALLE                           STRING   COMMENT 'Numéro salle',

    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_salle'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/salle'
;
