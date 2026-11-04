CREATE TABLE IF NOT EXISTS chu_dwh.dim_diagnostic (

    ID_DIM_DIAGNOSTIC INT
        COMMENT 'Cle de substitution du diagnostic. [PK logique]',

    CD_DIAGNOSTIC STRING
        COMMENT 'Code du diagnostic.',

    NM_DIAGNOSTIC STRING
        COMMENT 'Libelle du diagnostic.'

)

COMMENT 'Dimension : une ligne par diagnostic'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_diagnostic';
