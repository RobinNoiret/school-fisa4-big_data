DROP TABLE IF EXISTS chu_dwh.dim_professionnel;

CREATE TABLE chu_dwh.dim_professionnel (
  ID_DIM_PROFESSIONNEL     INT      COMMENT 'Clé de substitution du professionnel. [PK]',
  ID_PROFESSIONNEL         STRING   COMMENT 'Identifiant du professionnel (clé naturelle).',
  TXT_CIVILITE             STRING   COMMENT 'Civilité.',
  TXT_CATEGORIE_PRO        STRING   COMMENT 'Catégorie professionnelle.',
  TXT_PROFESSION           STRING   COMMENT 'Profession.',
  TXT_MODE_EXERCICE        STRING   COMMENT 'Mode d’exercice de l’activité principale.',
  FK_DIM_SPECIALITE        INT      COMMENT 'Spécialité. [FK DIM_SPECIALITE.ID_DIM_SPECIALITE]',
  FK_DIM_ETABLISSEMENT     INT      COMMENT 'Établissement de rattachement principal. [FK DIM_ETABLISSEMENT.ID_DIM_ETABLISSEMENT]'
)
COMMENT 'Dimension – 1 ligne = 1 professionnel de santé'
LOCATION '/user/cloudera/chu_dataplatform/dwh/dim_professionnel'
STORED AS ORC;
