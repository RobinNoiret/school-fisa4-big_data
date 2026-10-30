DROP TABLE IF EXISTS chu_dwh.dim_specialite;

CREATE TABLE chu_dwh.dim_specialite (
  ID_DIM_SPECIALITE        INT      COMMENT 'Clé de substitution de la spécialité. [PK]',
  CD_SPECIALITE            STRING   COMMENT 'Code de la spécialité.',
  NM_SPECIALITE            STRING   COMMENT 'Libellé de la spécialité.',
  NM_FONCTION              STRING   COMMENT 'Fonction.'
)
COMMENT 'Dimension – 1 ligne = 1 spécialité'
LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_specialite'
STORED AS ORC;
