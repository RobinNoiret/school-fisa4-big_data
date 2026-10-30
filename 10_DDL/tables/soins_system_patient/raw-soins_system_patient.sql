CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_patient (

    ID_PATIENT                         STRING   COMMENT 'Identifiant patient',
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
    NB_AGE                             STRING   COMMENT 'Nombre age',
    NB_NUM_SECU                        STRING   COMMENT 'Nombre numero securite sociale',
    CD_GROUPE_SANGUIN                  STRING   COMMENT 'Code groupe sanguin',
    NB_POID                            STRING   COMMENT 'Nombre poids',
    NB_TAILLE                          STRING   COMMENT 'Nombre taille'

)

COMMENT 'Table externe RAW soins_system_patient'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/patient'

;
