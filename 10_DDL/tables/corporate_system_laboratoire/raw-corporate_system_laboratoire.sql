CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_laboratoire (

    ID_LABORATOIRE                     STRING   COMMENT 'Identifiant laboratoire',
    NM_LABORATOIRE                     STRING   COMMENT 'Nom laboratoire',
    NM_PAYS                            STRING   COMMENT 'Nom pays'

)

COMMENT 'Table externe RAW corporate_system_laboratoire'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/laboratoire'

;
