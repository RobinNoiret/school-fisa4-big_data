CREATE TABLE IF NOT EXISTS chu_dwh.dim_etablissement (

    ID_DIM_ETABLISSEMENT INT
        COMMENT 'Cle de substitution de l etablissement',

    ID_ORGANISATION STRING
        COMMENT 'Identifiant organisation',

    CD_FINESS_SITE STRING
        COMMENT 'Code FINESS du site',

    TXT_RAISON_SOCIALE STRING
        COMMENT 'Raison sociale',

    NM_ENSEIGNE STRING
        COMMENT 'Enseigne commerciale',

    CD_POSTAL STRING
        COMMENT 'Code postal',

    FK_DIM_LOCALISATION INT
        COMMENT 'Localisation de l etablissement'

)

COMMENT 'Dimension etablissement'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_etablissement';
