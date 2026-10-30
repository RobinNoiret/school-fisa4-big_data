CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_etablissement (

    ID_TECH                            INT   COMMENT 'Identifiant technique',
    TXT_CEDEX                          STRING   COMMENT 'Texte cedex',
    CD_COMMUNE                         STRING   COMMENT 'Code commune',
    CD_POSTAL                          STRING   COMMENT 'Code postal',   
    TXT_COMMUNE                        STRING   COMMENT 'Texte commune',
    TXT_COMPLEMENT_DESTINATION         STRING   COMMENT 'Texte complement destination',
    TXT_POINT_GEOGRAPHIQUE             STRING   COMMENT 'Texte point géographique',
    TXT_EMAIL                          STRING   COMMENT 'Texte email',
    NM_ENSEIGNE_COMMERCIALE_SITE       STRING   COMMENT 'Nom enseigne commerciale site',
    CD_ETABLISSEMENT_JURIDIQUE         STRING   COMMENT 'Code etablissement juridique',
    CD_SITE                            STRING   COMMENT 'Code site',
    ID_ORGANISATION                    STRING   COMMENT 'Identifiant organisation',
    NB_REPETITION_VOIE                 STRING   COMMENT 'Nombre repetition voie',
    TXT_MENTION_DISTRIBUTION           STRING   COMMENT 'Texte mention distribution',
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
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_etablissement'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/etablissement'

;
