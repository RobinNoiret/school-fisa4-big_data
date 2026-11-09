CREATE TABLE IF NOT EXISTS chu_dwh.dim_temps (

    ID_DIM_TEMPS INT
        COMMENT 'Cle jour au format AAAAMMJJ',

    DT_JOUR DATE
        COMMENT 'Date du jour',

    NB_JOUR INT
        COMMENT 'Jour du mois',

    NM_JOUR_SEMAINE STRING
        COMMENT 'Nom du jour de la semaine',

    NB_MOIS INT
        COMMENT 'Numero du mois',

    NM_MOIS STRING
        COMMENT 'Nom du mois',

    FL_WEEK_END BOOLEAN
        COMMENT 'Indique si le jour est un samedi ou un dimanche'

)

COMMENT 'Dimension temps du 01/01/2015 au 31/12/2026'

PARTITIONED BY (

    NB_ANNEE INT
        COMMENT 'Annee'

)

CLUSTERED BY (ID_DIM_TEMPS)
INTO 4 BUCKETS

STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_temps';
