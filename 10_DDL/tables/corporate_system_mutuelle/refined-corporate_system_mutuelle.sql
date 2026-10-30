CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_mutuelle (

    ID_TECH                            INTEGER   COMMENT 'Identifiant technique',
    ID_MUTUELLE                        INTEGER   COMMENT 'Identifiant mutuelle',
    NM_MUTUELLE                        STRING    COMMENT 'Nom mutuelle',
    TXT_ADRESSE                        STRING    COMMENT 'Texte adresse',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_mutuelle'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/mutuelle'

;
