CREATE TABLE IF NOT EXISTS chu_dwh.table (

    sk_diagnostic   INT     COMMENT 'Cle technique de la dimension diagnostic - cle primaire logique',
    cd_diag         STRING      COMMENT 'Code du diagnostic - valeur obligatoire',
    lb_diagnostic   STRING      COMMENT 'Libelle du diagnostic'

)

COMMENT '...'

STORED AS ORC
LOCATION '/user/cloudera/chu_dataplatform/dwh/table'
;
