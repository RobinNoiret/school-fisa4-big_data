CREATE TABLE IF NOT EXISTS chu_refined.soins_system_patient (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    ID_PATIENT                         INT  COMMENT 'Identifiant patient',
    CD_SEXE                            STRING   COMMENT 'Code sexe',
    NM_VILLE                           STRING   COMMENT 'Nom ville',
    CD_DEPARTEMENT                     STRING   COMMENT 'Code departement',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    DT_NAISSANCE                       INT  COMMENT 'Année naissance',
    CD_GROUPE_SANGUIN                  STRING   COMMENT 'Code groupe sanguin',
    NB_POID                            STRING   COMMENT 'Nombre poids',
    NB_TAILLE                          STRING   COMMENT 'Nombre taille',

    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_patient'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/patient'
;
