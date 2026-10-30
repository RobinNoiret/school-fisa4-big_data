CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.corporate_system_professionnel_sante (

    ID_TECH                 INT     COMMENT 'Identifiant technique',
    ID_PROFESSIONNEL        STRING      COMMENT 'Identifiant du professionnel de sante',
    TXT_CIVILITE            STRING      COMMENT 'Civilite du professionnel de sante',
    TXT_CATEGORIE_PRO       STRING      COMMENT 'Categorie professionnelle du professionnel de sante',
    TXT_PROFESSION          STRING      COMMENT 'Profession du professionnel de sante',
    TXT_TYPE_IDENTIFIANT    STRING      COMMENT 'Type identifiant du professionnel de sante',
    CD_SPECIALITE           STRING      COMMENT 'Code specialite du professionnel de sante',
    TXT_SPECIALITE          STRING      COMMENT 'Specialite du professionnel de sante',
    TXT_COMMUNE             STRING      COMMENT 'Commune du professionnel de sante',
    ID_ORGANISATION         STRING      COMMENT 'Identifiant de l organisation du professionnel de sante',
    TXT_MODE_EXERCICE       STRING      COMMENT 'Mode d exercice du professionnel de sante'

)

COMMENT 'Table externe RAW corporate_system_professionnel_sante'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/corporate/system/professionnel_sante'
;
