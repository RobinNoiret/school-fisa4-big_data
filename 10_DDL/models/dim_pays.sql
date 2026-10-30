DROP TABLE IF EXISTS chu_dwh.dim_pays;

CREATE TABLE chu_dwh.dim_pays (
  ID_DIM_PAYS              INT      COMMENT 'Clé de substitution du pays. [PK]',
  NM_PAYS                  STRING   COMMENT 'Nom du pays (MAJUSCULES).'
)
COMMENT 'Dimension – 1 ligne = 1 pays'
LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_pays'
STORED AS ORC;
