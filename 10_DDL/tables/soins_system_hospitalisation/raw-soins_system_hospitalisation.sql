CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_hospitalisation (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    ID_HOSPITALISATION                 INT  COMMENT 'Identifiant hospitalisation',
    ID_PATIENT                         INT  COMMENT 'Identifiant patient',
    ID_ORIGANISATION                   STRING   COMMENT 'Identifiant organisation',
    CD_DIAGNOSTIC                      STRING   COMMENT 'Code diagnostic',
    DESC_DIAGNOSTIC                    STRING   COMMENT 'Description diagnostic',
    DT_ENTREE                          STRING   COMMENT 'Date entree AAAA-MM-JJ',
    NB_JOUR                            INT  COMMENT 'Nombre jour'

)

COMMENT 'Table externe RAW soins_system_hospitalisation'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/hospitalisations'

;
