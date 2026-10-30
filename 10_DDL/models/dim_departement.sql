DROP TABLE IF EXISTS chu_dwh.dim_departement;

CREATE TABLE chu_dwh.dim_departement (
  ID_DIM_DEPARTEMENT       INT      COMMENT 'Clé de substitution du département. [PK]',
  CD_DEPARTEMENT           STRING   COMMENT 'Code département.',
  FK_DIM_PAYS              INT      COMMENT 'Pays du département. [FK DIM_PAYS.ID_DIM_PAYS]'
)
COMMENT 'Dimension – 1 ligne = 1 département'
STORED AS ORC;
