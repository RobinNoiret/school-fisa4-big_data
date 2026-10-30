CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_prescription (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    ID_CONSULTATION                    INT  COMMENT 'Identifiant consultation',
    CD_CIS                             STRING   COMMENT 'Code CIS'

)

COMMENT 'Table externe RAW soins_system_prescription'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/prescription'

;
