CREATE TABLE IF NOT EXISTS chu_dwh.dim_mutuelle (

    ID_DIM_MUTUELLE INT,
    ID_MUTUELLE INT,
    NM_MUTUELLE STRING

)

COMMENT 'Dimension mutuelle'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_mutuelle';
