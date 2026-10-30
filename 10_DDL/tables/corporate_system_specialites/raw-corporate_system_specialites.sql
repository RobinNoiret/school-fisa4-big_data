CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_specialites (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    CD_SPECIALITE                      STRING   COMMENT 'Code specialite',
    NM_FONCTION                        STRING   COMMENT 'Nom fonction',
    NM_SPECIALITE                      STRING   COMMENT 'Nom specialite'

)

COMMENT 'Table externe RAW corporate_system_specialites'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/specialites'

;
