CREATE TABLE IF NOT EXISTS chu_dwh.dim_specialite (

    ID_DIM_SPECIALITE INT
        COMMENT 'Cle de substitution de la specialite. [PK logique]',

    CD_SPECIALITE STRING
        COMMENT 'Code de la specialite.',

    NM_SPECIALITE STRING
        COMMENT 'Libelle de la specialite.',

    NM_FONCTION STRING
        COMMENT 'Fonction associee.'

)

COMMENT 'Dimension : une ligne par specialite'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_specialite';
