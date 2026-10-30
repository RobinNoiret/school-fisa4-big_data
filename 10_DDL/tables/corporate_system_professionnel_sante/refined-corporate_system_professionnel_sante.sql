CREATE TABLE IF NOT EXISTS chu_refined.corporate_system_professionnel_sante (

    ID_TECH                 INTEGER     COMMENT 'Identifiant technique',
    ID_PROFESSIONNEL        STRING      COMMENT 'Identifiant du professionnel de sante',
    TXT_CIVILITE            STRING      COMMENT 'Civilite du professionnel de sante',
    TXT_CATEGORIE_PRO       STRING      COMMENT 'Categorie professionnelle du professionnel de sante',
    TXT_PROFESSION          STRING      COMMENT 'Profession du professionnel de sante',
    TXT_TYPE_IDENTIFIANT    STRING      COMMENT 'Type identifiant du professionnel de sante',
    CD_SPECIALITE           STRING      COMMENT 'Code specialite du professionnel de sante',
    TXT_SPECIALITE          STRING      COMMENT 'Specialite du professionnel de sante',
    TXT_COMMUNE             STRING      COMMENT 'Commune du professionnel de sante',
    ID_ORGANISATION         STRING      COMMENT 'Identifiant de l organisation du professionnel de sante',
    TXT_MODE_EXERCICE       STRING      COMMENT 'Mode d exercice du professionnel de sante',

    -- champs techniques
    fl_active               BOOLEAN     COMMENT 'Indique si la ligne est active selon les regles du flux',
    nm_file                 STRING      COMMENT 'Chemin HDFS du fichier RAW utilise pour le chargement',
    nm_provider             STRING      COMMENT 'Nom du fournisseur des donnees'

)

COMMENT 'Table interne REFINED du flux corporate_system_professionnel_sante'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/corporate/system/professionnel_sante'
;
