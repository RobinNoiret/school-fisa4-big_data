CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.demographie_insee_deces (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    NM_SEXE                            INT  COMMENT 'Nom sexe',
    DT_NAISSANCE                       INT  COMMENT 'Année naissance',
    CD_LIEU_NAISSANCE                  STRING   COMMENT 'Code lieu naissance',
    NM_VILLE                           STRING   COMMENT 'Nom ville',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    DT_DECES                           INT  COMMENT 'Année deces',
    CD_LIEU_DECES                      STRING   COMMENT 'Code lieu deces',
    NB_ACTE_DECES                      STRING   COMMENT 'Numéro acte deces'

)

COMMENT 'Table externe RAW demographie_insee_deces'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/demographie/insee/deces'

;
