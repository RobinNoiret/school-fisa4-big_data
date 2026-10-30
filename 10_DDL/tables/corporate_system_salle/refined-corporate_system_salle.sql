CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_salle (

    ID_SALLE                           STRING   COMMENT 'Identifiant salle',
    ID_CONSULTATION                    INT      COMMENT 'Identifiant consultation',
    CD_BLOC                            STRING   COMMENT 'Code bloc',
    NB_ETAGE                           STRING   COMMENT 'Nombre etage',
    NB_SALLE                           STRING   COMMENT 'Nombre salle',

    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_salle'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/salle'
;
