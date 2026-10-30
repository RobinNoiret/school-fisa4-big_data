DROP TABLE IF EXISTS chu_dwh.dim_temps;

CREATE TABLE chu_dwh.dim_temps (
  ID_DIM_TEMPS             INT      COMMENT 'Clé jour au format yyyymmdd. [PK]',
  DT_JOUR                  DATE     COMMENT 'Date du jour.',
  NB_JOUR                  INT      COMMENT 'Jour du mois (1-31).',
  NM_JOUR_SEMAINE          STRING   COMMENT 'Nom du jour (lundi à dimanche).',
  NB_MOIS                  INT      COMMENT 'Mois (1-12).',
  NM_MOIS                  STRING   COMMENT 'Nom du mois.',
  NB_ANNEE                 INT      COMMENT 'Année.',
  FL_WEEK_END              BOOLEAN  COMMENT 'Samedi ou dimanche ?'
)
COMMENT 'Dimension – 1 ligne = 1 jour, de date.DT_DEBUT à date.DT_FIN'
STORED AS ORC;
