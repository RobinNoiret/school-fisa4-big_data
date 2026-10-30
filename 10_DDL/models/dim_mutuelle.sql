DROP TABLE IF EXISTS chu_dwh.dim_mutuelle;

CREATE TABLE chu_dwh.dim_mutuelle (
  ID_DIM_MUTUELLE          INT      COMMENT 'Clé de substitution de la mutuelle. [PK]',
  ID_MUTUELLE              INT      COMMENT 'Identifiant de la mutuelle (clé naturelle).',
  NM_MUTUELLE              STRING   COMMENT 'Nom de la mutuelle.'
)
COMMENT 'Dimension – 1 ligne = 1 mutuelle'
STORED AS ORC;
