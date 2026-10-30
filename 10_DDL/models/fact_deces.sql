DROP TABLE IF EXISTS chu_dwh.fact_deces;

CREATE TABLE chu_dwh.fact_deces (
  ID_FAIT_DECES            INT      COMMENT 'Clé de substitution du décès. [PK]',
  FK_DIM_DEPARTEMENT_DECES INT      COMMENT 'Département du lieu de décès. [FK DIM_DEPARTEMENT.ID_DIM_DEPARTEMENT]',
  FK_DIM_PAYS_NAISSANCE    INT      COMMENT 'Pays de naissance. [FK DIM_PAYS.ID_DIM_PAYS]',
  CD_SEXE                  STRING   COMMENT 'Sexe (M / F).',
  NB_ANNEE_DECES           INT      COMMENT 'Année du décès.',
  NB_AGE_DECES             INT      COMMENT 'Âge au décès (en années).'
)
COMMENT 'Fait – 1 ligne = 1 décès (fichier INSEE)'
LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_deces'
STORED AS ORC;
