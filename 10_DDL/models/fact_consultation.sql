DROP TABLE IF EXISTS chu_dwh.fact_consultation;

CREATE TABLE chu_dwh.fact_consultation (
  ID_CONSULTATION          INT      COMMENT 'Identifiant de la consultation (dimension dégénérée). [PK]',
  FK_DIM_TEMPS             INT      COMMENT 'Date de la consultation. [FK DIM_TEMPS.ID_DIM_TEMPS]',
  FK_DIM_PATIENT           INT      COMMENT 'Patient consulté. [FK DIM_PATIENT.ID_DIM_PATIENT]',
  FK_DIM_PROFESSIONNEL     INT      COMMENT 'Professionnel ayant consulté. [FK DIM_PROFESSIONNEL.ID_DIM_PROFESSIONNEL]',
  FK_DIM_DIAGNOSTIC        INT      COMMENT 'Diagnostic posé. [FK DIM_DIAGNOSTIC.ID_DIM_DIAGNOSTIC]',
  FK_DIM_MUTUELLE          INT      COMMENT 'Mutuelle utilisée. [FK DIM_MUTUELLE.ID_DIM_MUTUELLE]',
  NB_AGE_PATIENT           INT      COMMENT 'Âge du patient le jour de la consultation (en années).',
  DUR_CONSULTATION_MIN     INT      COMMENT 'Durée de la consultation en minutes.'
)
COMMENT 'Fait – 1 ligne = 1 consultation'
LOCATION '/user/cloudera/chu_dataplatform/dwh/fact_consultation'
STORED AS ORC;
