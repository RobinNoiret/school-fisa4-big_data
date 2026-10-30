DROP TABLE IF EXISTS chu_dwh.dim_ville;

CREATE TABLE chu_dwh.dim_ville (
  ID_DIM_VILLE             INT      COMMENT 'Clé de substitution de la ville. [PK]',
  NM_VILLE                 STRING   COMMENT 'Nom de la ville.',
  FK_DIM_DEPARTEMENT       INT      COMMENT 'Département de la ville. [FK DIM_DEPARTEMENT.ID_DIM_DEPARTEMENT]'
)
COMMENT 'Dimension – 1 ligne = 1 ville dans un département'
STORED AS ORC;
