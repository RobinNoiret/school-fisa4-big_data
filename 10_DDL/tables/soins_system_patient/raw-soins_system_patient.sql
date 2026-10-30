CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_patient (

    ID_TECH                            INTEGER  COMMENT 'Identifiant technique',
    ID_PATIENT                         INTEGER  COMMENT 'Identifiant patient',
    CD_SEXE                            STRING   COMMENT 'Code sexe',
    NM_VILLE                           STRING   COMMENT 'Nom ville',
    CD_DEPARTEMENT                     STRING   COMMENT 'Code departement',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    DT_NAISSANCE                       INTEGER  COMMENT 'Année naissance',
    CD_GROUPE_SANGUIN                  STRING   COMMENT 'Code groupe sanguin',
    NB_POID                            STRING   COMMENT 'Nombre poids',
    NB_TAILLE                          STRING   COMMENT 'Nombre taille'

)

COMMENT 'Table externe RAW soins_system_patient'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/patient'

;
