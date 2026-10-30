CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_laboratoire (

    ID_LABORATOIRE                     INT      COMMENT 'Identifiant laboratoire',
    NM_LABORATOIRE                     STRING   COMMENT 'Nom laboratoire',
    NM_PAYS                            STRING   COMMENT 'Nom pays',

    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED corporate_system_laboratoire'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/laboratoire'
;
