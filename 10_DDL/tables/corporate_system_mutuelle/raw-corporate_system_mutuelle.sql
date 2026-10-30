CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_mutuelle (

    ID_MUTUELLE                        STRING   COMMENT 'Identifiant mutuelle',
    NM_MUTUELLE                        STRING   COMMENT 'Nom mutuelle',
    TXT_ADRESSE                        STRING   COMMENT 'Texte adresse'

)

COMMENT 'Table externe RAW corporate_system_mutuelle'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/mutuelle'

;
