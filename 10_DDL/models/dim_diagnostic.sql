CREATE TABLE IF NOT EXISTS chu_dwh.dim_diagnostic (

    ID_DIM_DIAGNOSTIC INT,
    CD_DIAGNOSTIC STRING,
    NM_DIAGNOSTIC STRING

)

COMMENT 'Dimension diagnostic'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_diagnostic';
