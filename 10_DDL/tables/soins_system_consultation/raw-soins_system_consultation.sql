CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_consultation (

    ID_CONSULTATION                    STRING   COMMENT 'Identifiant consultation',
    ID_MUTUELLE                        STRING   COMMENT 'Identifiant mutuelle',
    ID_PATIENT                         STRING   COMMENT 'Identifiant patient',
    ID_PROFESSIONNEL_SANTE             STRING   COMMENT 'Identifiant professionnel sante',
    CD_DIAGNOSTIC                      STRING   COMMENT 'Code diagnostic',
    TXT_MOTIF                          STRING   COMMENT 'Texte motif',
    DT_CONSULTATION                    STRING   COMMENT 'Date consultation',
    TS_DEBUT                           STRING   COMMENT 'Heure debut',
    TS_FIN                             STRING   COMMENT 'Heure fin'

)

COMMENT 'Table externe RAW soins_system_consultation'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/consultation'

;
