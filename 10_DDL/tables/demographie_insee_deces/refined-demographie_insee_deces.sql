CREATE TABLE IF NOT EXISTS chu_refined.demographie_insee_deces (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    NM_SEXE                            INT  COMMENT 'Nom sexe',
    DT_NAISSANCE                       INT  COMMENT 'Année naissance',
    CD_LIEU_NAISSANCE                  STRING   COMMENT 'Code lieu naissance',
    NM_VILLE                           STRING   COMMENT 'Nom ville',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    DT_DECES                           INT  COMMENT 'Année deces',
    CD_LIEU_DECES                      STRING   COMMENT 'Code lieu deces',
    NB_ACTE_DECES                      STRING   COMMENT 'Numéro acte deces',

    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED demographie_insee_deces'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/demographie/insee/deces'

;
