DROP TABLE IF EXISTS chu_dwh.dim_diagnostic;

CREATE TABLE chu_dwh.dim_diagnostic (
  ID_DIM_DIAGNOSTIC        INT      COMMENT 'Clé de substitution du diagnostic. [PK]',
  CD_DIAGNOSTIC            STRING   COMMENT 'Code du diagnostic.',
  NM_DIAGNOSTIC            STRING   COMMENT 'Libellé du diagnostic.'
)
COMMENT 'Dimension – 1 ligne = 1 diagnostic'
STORED AS ORC;
