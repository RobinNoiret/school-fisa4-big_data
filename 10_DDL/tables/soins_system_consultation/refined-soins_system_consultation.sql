CREATE TABLE IF NOT EXISTS chu_refined.soins_system_consultation (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    ID_CONSULTATION                    INTEGER  COMMENT 'Identifiant consultation',
    ID_MUTUELLE                        INTEGER  COMMENT 'Identifiant mutuelle',
    ID_PATIENT                         INTEGER  COMMENT 'Identifiant patient',
    ID_PROFESSIONNEL_SANTE             STRING   COMMENT 'Identifiant professionnel sante',
    CD_DIAGNOSTIC                      STRING   COMMENT 'Code diagnostic',
    TXT_MOTIF                          STRING   COMMENT 'Texte motif',
    DT_CONSULTATION                    DATE     COMMENT 'Date consultation',
    TS_DEBUT                           STRING   COMMENT 'Heure debut',
    TS_FIN                             STRING   COMMENT 'Heure fin',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_consultation'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/consultation'
;
