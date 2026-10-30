CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_etablissement (

    TXT_ADRESSE                        STRING   COMMENT 'Texte adresse',
    TXT_CEDEX                          STRING   COMMENT 'Texte cedex',
    CD_COMMUNE                         INT      COMMENT 'Code commune',
    CD_POSTAL                          STRING   COMMENT 'Code postal',
    TXT_COMMUNE                        STRING   COMMENT 'Texte commune',
    TXT_COMPLEMENT_DESTINATION         STRING   COMMENT 'Texte complement destination',
    TXT_POINT_GÉOGRAPHIQUE             STRING   COMMENT 'Texte point géographique',
    TXT_EMAIL                          STRING   COMMENT 'Texte email',
    NM_ENSEIGNE_COMMERCIALE_SITE       STRING   COMMENT 'Nom enseigne commerciale site',
    CD_ETABLISSEMENT_JURIDIQUE         INT      COMMENT 'Code etablissement juridique',
    CD_SITE                            INT      COMMENT 'Code site',
    ID_ORGANISATION                    STRING   COMMENT 'Identifiant organisation',
    NB_REPETITION_VOIE                 STRING   COMMENT 'Nombre repetition voie',
    TXT_METION_DISTRIBUTION            STRING   COMMENT 'Texte mention distribution',
    NB_VOIE                            INT      COMMENT 'Nombre voie',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    TXT_RAISON_SOCIALE                 STRING   COMMENT 'Texte raison sociale',
    NB_SIREN_SITE                      INT      COMMENT 'Nombre SIREN site',
    NB_SIRET_SITE                      INT      COMMENT 'Nombre SIRET site',
    TXT_TELECOPIE                      INT      COMMENT 'Texte telecopie',
    NB_TEL                             INT      COMMENT 'Nombre telephone',
    NB_TEL_BIS                         INT      COMMENT 'Nombre telephone secondaire',
    NM_TYPE_VOIE                       STRING   COMMENT 'Nom type voie',
    TXT_VOIE                           STRING   COMMENT 'Texte voie',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_etablissement'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/etablissement'

;
