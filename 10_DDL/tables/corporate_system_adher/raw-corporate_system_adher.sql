CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_adher (

    ID_PATIENT                         INTEGER   COMMENT 'Identifiant patient',
    ID_MUTUELLE                        INTEGER   COMMENT 'Identifiant mutuelle'

)

COMMENT 'Table externe RAW corporate_system_adher'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/adher'

;
