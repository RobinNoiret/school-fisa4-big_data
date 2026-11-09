CREATE TABLE IF NOT EXISTS chu_dwh.fact_hospitalisation (

    ID_HOSPITALISATION INT,
    FK_DIM_TEMPS_ENTREE INT,
    FK_DIM_TEMPS_SORTIE INT,
    FK_DIM_PATIENT INT,
    FK_DIM_ETABLISSEMENT INT,
    FK_DIM_DIAGNOSTIC INT,

    NB_AGE_PATIENT INT
        COMMENT 'Age estime du patient a l entree',

    DUR_SEJOUR_JOUR INT,
    DESC_DIAGNOSTIC STRING

)

COMMENT 'Fait : une ligne par hospitalisation'

PARTITIONED BY (

    NB_ANNEE_ENTREE INT

)

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_hospitalisation';
