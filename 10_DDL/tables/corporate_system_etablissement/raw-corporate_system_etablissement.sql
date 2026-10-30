CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_etablissement (

    TXT_ADRESSE                        STRING   COMMENT 'Texte adresse',
    TXT_CEDEX                          STRING   COMMENT 'Texte cedex',
    CD_COMMUNE                         STRING   COMMENT 'Code commune',
    CD_POSTAL                          STRING   COMMENT 'Code postal',
    TXT_COMMUNE                        STRING   COMMENT 'Texte commune',
    TXT_COMPLEMENT_DESTINATION         STRING   COMMENT 'Texte complement destination',
    TXT_POINT_GÉOGRAPHIQUE             STRING   COMMENT 'Texte point géographique',
    TXT_EMAIL                          STRING   COMMENT 'Texte email',
    NM_ENSEIGNE_COMMERCIALE_SITE       STRING   COMMENT 'Nom enseigne commerciale site',
    CD_ETABLISSEMENT_JURIDIQUE         STRING   COMMENT 'Code etablissement juridique',
    CD_SITE                            STRING   COMMENT 'Code site',
    ID_ORGANISATION                    STRING   COMMENT 'Identifiant organisation',
    NB_REPETITION_VOIE                 STRING   COMMENT 'Nombre repetition voie',
    TXT_METION_DISTRIBUTION            STRING   COMMENT 'Texte mention distribution',
    NB_VOIE                            STRING   COMMENT 'Nombre voie',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    TXT_RAISON_SOCIALE                 STRING   COMMENT 'Texte raison sociale',
    NB_SIREN_SITE                      STRING   COMMENT 'Nombre SIREN site',
    NB_SIRET_SITE                      STRING   COMMENT 'Nombre SIRET site',
    TXT_TELECOPIE                      STRING   COMMENT 'Texte telecopie',
    NB_TEL                             STRING   COMMENT 'Nombre telephone',
    NB_TEL_BIS                         STRING   COMMENT 'Nombre telephone secondaire',
    NM_TYPE_VOIE                       STRING   COMMENT 'Nom type voie',
    TXT_VOIE                           STRING   COMMENT 'Texte voie'

)

COMMENT 'Table externe RAW corporate_system_etablissement'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/etablissement'

;
