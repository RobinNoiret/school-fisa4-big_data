CREATE TABLE IF NOT EXISTS chu_dwh.fact_consultation (

    ID_CONSULTATION INT
        COMMENT 'Identifiant de la consultation. [PK logique]',

    FK_DIM_TEMPS INT
        COMMENT 'Date de la consultation. [FK DIM_TEMPS]',

    FK_DIM_PATIENT INT
        COMMENT 'Patient consulte. [FK DIM_PATIENT]',

    FK_DIM_PROFESSIONNEL INT
        COMMENT 'Professionnel ayant consulte. [FK DIM_PROFESSIONNEL]',

    FK_DIM_ETABLISSEMENT INT
        COMMENT 'Etablissement reel de consultation si connu. [FK DIM_ETABLISSEMENT]',

    FK_DIM_DIAGNOSTIC INT
        COMMENT 'Diagnostic pose. [FK DIM_DIAGNOSTIC]',

    FK_DIM_MUTUELLE INT
        COMMENT 'Mutuelle utilisee. [FK DIM_MUTUELLE]',

    NB_AGE_PATIENT INT
        COMMENT 'Age estime du patient a la consultation en annees.',

    DUR_CONSULTATION_MIN INT
        COMMENT 'Duree de la consultation en minutes.'

)

COMMENT 'Fait : une ligne par consultation'

PARTITIONED BY (

    NB_ANNEE_CONSULTATION INT
        COMMENT 'Annee de la consultation.'

)

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_consultation';
