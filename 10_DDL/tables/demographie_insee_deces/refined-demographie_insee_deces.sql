CREATE TABLE IF NOT EXISTS chu_refined.demographie_insee_deces (

    ID_TECH INT                 COMMENT 'Identifiant technique',
    NM_SEXE INT                 COMMENT 'Nom sexe',
    DT_NAISSANCE INT            COMMENT 'Annee naissance',
    CD_LIEU_NAISSANCE STRING    COMMENT 'Code lieu naissance',
    NM_VILLE STRING             COMMENT 'Nom ville',
    NM_PAYS STRING              COMMENT 'Nom pays',
    CD_LIEU_DECES STRING        COMMENT 'Code lieu deces',
    NB_ACTE_DECES STRING        COMMENT 'Numero acte deces',

    -- Champs techniques
    FL_ACTIVE BOOLEAN           COMMENT 'Ligne active',
    NM_FILE STRING              COMMENT 'Fichier source',
    NM_PROVIDER STRING          COMMENT 'Systeme source'

)

COMMENT 'Table de test REFINED demographie_insee_deces'

PARTITIONED BY (DT_DECES INT COMMENT 'Annee de deces')
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/demographie/insee/deces';
