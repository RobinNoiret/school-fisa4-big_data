CREATE TABLE IF NOT EXISTS chu_dwh.dim_mutuelle (

    ID_DIM_MUTUELLE INT
        COMMENT 'Cle de substitution de la mutuelle. [PK logique]',

    ID_MUTUELLE INT
        COMMENT 'Identifiant de la mutuelle.',

    NM_MUTUELLE STRING
        COMMENT 'Nom de la mutuelle.'

)

COMMENT 'Dimension : une ligne par mutuelle'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_mutuelle';
