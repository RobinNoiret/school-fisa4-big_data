DROP TABLE IF EXISTS chu_dwh.fait_hospitalisation;

CREATE TABLE chu_dwh.fait_hospitalisation (
  ID_HOSPITALISATION       INT      COMMENT 'Identifiant du séjour (dimension dégénérée). [PK]',
  FK_DIM_TEMPS_ENTREE      INT      COMMENT 'Date d’entrée. [FK DIM_TEMPS.ID_DIM_TEMPS]',
  FK_DIM_TEMPS_SORTIE      INT      COMMENT 'Date de sortie. [FK DIM_TEMPS.ID_DIM_TEMPS]',
  FK_DIM_PATIENT           INT      COMMENT 'Patient hospitalisé. [FK DIM_PATIENT.ID_DIM_PATIENT]',
  FK_DIM_ETABLISSEMENT     INT      COMMENT 'Établissement d’hospitalisation. [FK DIM_ETABLISSEMENT.ID_DIM_ETABLISSEMENT]',
  FK_DIM_DIAGNOSTIC        INT      COMMENT 'Diagnostic d’hospitalisation. [FK DIM_DIAGNOSTIC.ID_DIM_DIAGNOSTIC]',
  NB_AGE_PATIENT           INT      COMMENT 'Âge du patient à l’entrée (en années).',
  DUR_SEJOUR_JOUR          INT      COMMENT 'Durée du séjour en jours.',
  DESC_DIAGNOSTIC          STRING   COMMENT 'Suite donnée au diagnostic.'
)
COMMENT 'Fait – 1 ligne = 1 séjour d’hospitalisation'
STORED AS ORC;
