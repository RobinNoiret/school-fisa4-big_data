CREATE TABLE IF NOT EXISTS chu_dwh.fact_consultation (

    ID_CONSULTATION INT,
    FK_DIM_TEMPS INT,
    FK_DIM_PATIENT INT,
    FK_DIM_PROFESSIONNEL INT,

    FK_DIM_ETABLISSEMENT INT
        COMMENT 'Etablissement de rattachement principal du professionnel si connu',

    FK_DIM_DIAGNOSTIC INT,
    FK_DIM_MUTUELLE INT,

    NB_AGE_PATIENT INT
        COMMENT 'Age estime du patient lors de la consultation',

    DUR_CONSULTATION_MIN INT

)

COMMENT 'Fait : une ligne par consultation'

PARTITIONED BY (

    NB_ANNEE_CONSULTATION INT

)

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_consultation';
