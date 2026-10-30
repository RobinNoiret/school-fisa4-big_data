DROP TABLE IF EXISTS chu_dwh.dim_patient;

CREATE TABLE chu_dwh.dim_patient (
  ID_DIM_PATIENT           INT      COMMENT 'Clé de substitution du patient. [PK]',
  ID_PATIENT               INT      COMMENT 'Identifiant pseudonymisé du patient (clé naturelle).',
  CD_SEXE                  STRING   COMMENT 'Sexe du patient.',
  NB_ANNEE_NAISSANCE       INT      COMMENT 'Année de naissance.',
  CD_GROUPE_SANGUIN        STRING   COMMENT 'Groupe sanguin.',
  FK_DIM_VILLE             INT      COMMENT 'Ville de résidence. [FK DIM_VILLE.ID_DIM_VILLE]'
)
COMMENT 'Dimension – 1 ligne = 1 patient'
STORED AS ORC;
