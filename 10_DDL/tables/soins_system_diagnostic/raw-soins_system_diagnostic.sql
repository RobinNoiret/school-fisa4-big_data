CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_diagnostic (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    CD_DIAGNOSTIC                      STRING   COMMENT 'Code diagnostic',
    NM_DIAGNOSTIC                      STRING   COMMENT 'Nom diagnostic'

)

COMMENT 'Table externe RAW soins_system_diagnostic'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/diagnostic'

;
