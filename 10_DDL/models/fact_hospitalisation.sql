CREATE TABLE IF NOT EXISTS chu_dwh.fact_hospitalisation (

    ID_HOSPITALISATION INT
        COMMENT 'Identifiant du sejour. [PK logique]',

    FK_DIM_TEMPS_ENTREE INT
        COMMENT 'Date d entree. [FK DIM_TEMPS]',

    FK_DIM_TEMPS_SORTIE INT
        COMMENT 'Date de sortie. [FK DIM_TEMPS]',

    FK_DIM_PATIENT INT
        COMMENT 'Patient hospitalise. [FK DIM_PATIENT]',

    FK_DIM_ETABLISSEMENT INT
        COMMENT 'Etablissement d hospitalisation. [FK DIM_ETABLISSEMENT]',

    FK_DIM_DIAGNOSTIC INT
        COMMENT 'Diagnostic d hospitalisation. [FK DIM_DIAGNOSTIC]',

    NB_AGE_PATIENT INT
        COMMENT 'Age estime du patient a l entree en annees.',

    DUR_SEJOUR_JOUR INT
        COMMENT 'Duree du sejour en jours.',

    DESC_DIAGNOSTIC STRING
        COMMENT 'Suite donnee au diagnostic.'

)

COMMENT 'Fait : une ligne par sejour d hospitalisation'

PARTITIONED BY (

    NB_ANNEE_ENTREE INT
        COMMENT 'Annee d entree en hospitalisation.'

)

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_hospitalisation';
