CREATE TABLE IF NOT EXISTS chu_dwh.dim_professionnel (

    ID_DIM_PROFESSIONNEL INT
        COMMENT 'Cle de substitution du professionnel. [PK logique]',

    ID_PROFESSIONNEL STRING
        COMMENT 'Identifiant du professionnel.',

    TXT_CIVILITE STRING
        COMMENT 'Civilite.',

    TXT_CATEGORIE_PRO STRING
        COMMENT 'Categorie professionnelle.',

    TXT_PROFESSION STRING
        COMMENT 'Profession.',

    TXT_MODE_EXERCICE STRING
        COMMENT 'Mode d exercice de l activite principale.',

    FK_DIM_SPECIALITE INT
        COMMENT 'Specialite. [FK DIM_SPECIALITE]',

    FK_DIM_ETABLISSEMENT INT
        COMMENT 'Etablissement de rattachement principal. [FK DIM_ETABLISSEMENT]'

)

COMMENT 'Dimension : une ligne par professionnel de sante'

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_professionnel';
