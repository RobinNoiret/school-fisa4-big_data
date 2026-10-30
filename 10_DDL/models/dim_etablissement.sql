DROP TABLE IF EXISTS chu_dwh.dim_etablissement;

CREATE TABLE chu_dwh.dim_etablissement (
  ID_DIM_ETABLISSEMENT     INT      COMMENT 'Clé de substitution de l’établissement. [PK]',
  ID_ORGANISATION          STRING   COMMENT 'Identifiant de l’organisation (clé naturelle).',
  CD_FINESS_SITE           STRING   COMMENT 'Numéro FINESS géographique.',
  TXT_RAISON_SOCIALE       STRING   COMMENT 'Raison sociale.',
  NM_ENSEIGNE              STRING   COMMENT 'Enseigne commerciale.',
  CD_POSTAL                STRING   COMMENT 'Code postal.',
  FK_DIM_VILLE             INT      COMMENT 'Commune de l’établissement. [FK DIM_VILLE.ID_DIM_VILLE]'
)
COMMENT 'Dimension – 1 ligne = 1 établissement (organisation)'
LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_etablissement'
STORED AS ORC;
