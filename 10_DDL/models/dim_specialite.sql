CREATE TABLE IF NOT EXISTS chu_dwh.dim_specialite (

    ID_DIM_SPECIALITE INT,
    CD_SPECIALITE STRING,
    NM_SPECIALITE STRING,
    NM_FONCTION STRING

)

COMMENT 'Dimension specialite'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_specialite';
