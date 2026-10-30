CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.table (

    id_source   STRING      COMMENT 'Identifiant dans le systeme source',
    lb_exemple  STRING      COMMENT 'Libelle provenant du systeme source',
    valeur      STRING      COMMENT 'Valeur brute provenant du systeme source'

)

COMMENT 'Table externe RAW flux '

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/activiy/provider/flux'
;
