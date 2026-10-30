CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_salle (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    ID_SALLE                           STRING   COMMENT 'Identifiant salle',
    ID_CONSULTATION                    INTEGER  COMMENT 'Identifiant consultation',
    CD_BLOC                            STRING   COMMENT 'Code bloc',
    NB_ETAGE                           STRING   COMMENT 'Numéro etage',
    NB_SALLE                           STRING   COMMENT 'Numéro salle'

)

COMMENT 'Table externe RAW corporate_system_salle'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/salle'
;
