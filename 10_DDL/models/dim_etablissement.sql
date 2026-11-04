CREATE TABLE IF NOT EXISTS chu_dwh.dim_etablissement (

    ID_DIM_ETABLISSEMENT INT
        COMMENT 'Cle de substitution de l etablissement. [PK logique]',

    ID_ORGANISATION STRING
        COMMENT 'Identifiant de l organisation.',

    CD_FINESS_SITE STRING
        COMMENT 'Numero FINESS geographique du site.',

    TXT_RAISON_SOCIALE STRING
        COMMENT 'Raison sociale.',

    NM_ENSEIGNE STRING
        COMMENT 'Enseigne commerciale.',

    CD_POSTAL STRING
        COMMENT 'Code postal de l etablissement.',

    FK_DIM_LOCALISATION INT
        COMMENT 'Localisation de l etablissement. [FK DIM_LOCALISATION]'

)

COMMENT 'Dimension etablissement'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_etablissement';
