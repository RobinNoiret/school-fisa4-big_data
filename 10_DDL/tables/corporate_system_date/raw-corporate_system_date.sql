CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_date (

    DT_DEBUT                           STRING   COMMENT 'Date debut',
    DT_FIN                             STRING   COMMENT 'Date fin'

)

COMMENT 'Table externe RAW corporate_system_date'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/date'

;
