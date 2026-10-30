CREATE TABLE IF NOT EXISTS chu_dwh.dim_diagnostic (

    sk_diagnostic   INT     COMMENT 'Cle technique de la dimension diagnostic - cle primaire logique',
    cd_diag         STRING      COMMENT 'Code du diagnostic - valeur obligatoire',
    lb_diagnostic   STRING      COMMENT 'Libelle du diagnostic'

)

COMMENT 'Dimension des diagnostics'

STORED AS ORC
LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_diagnostic'
;
