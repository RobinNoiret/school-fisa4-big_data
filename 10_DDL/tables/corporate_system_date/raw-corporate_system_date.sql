CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_date (

    ID_TECH  INT  COMMENT 'Identifiant technique',
    DT_DEBUT DATE COMMENT 'Date debut',
    DT_FIN   DATE COMMENT 'Date fin'

)

COMMENT 'Table externe RAW corporate_system_date'

ROW FORMAT DELIMITED
FIELDS TERMINATED BY ';'

STORED AS TEXTFILE

LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/date';
