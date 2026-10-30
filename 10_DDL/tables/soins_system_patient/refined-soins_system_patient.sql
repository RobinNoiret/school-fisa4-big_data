CREATE TABLE IF NOT EXISTS chu_refined.soins_system_patient (

    ID_PATIENT                         INT      COMMENT 'Identifiant patient',
    NM_NOM_PATIENT                     STRING   COMMENT 'Nom nom patient',
    NM_PRENOM_PATIENT                  STRING   COMMENT 'Nom prenom patient',
    CD_SEXE                            STRING   COMMENT 'Code sexe',
    TXT_ADRESSE                        STRING   COMMENT 'Texte adresse',
    NM_VILLE                           STRING   COMMENT 'Nom ville',
    CD_POSTAL                          STRING   COMMENT 'Code postal',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    TXT_EMAIL                          STRING   COMMENT 'Texte email',
    NB_TEL                             STRING   COMMENT 'Nombre telephone',
    DT_NAISSANCE                       STRING   COMMENT 'Date naissance',
    NB_AGE                             INT      COMMENT 'Nombre age',
    NB_NUM_SECU                        STRING   COMMENT 'Nombre numero securite sociale',
    CD_GROUPE_SANGUIN                  STRING   COMMENT 'groupe sanguin',
    NB_POID                            STRING   COMMENT 'poids',
    NB_TAILLE                          STRING   COMMENT 'taille',

    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_patient'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/patient'
;
