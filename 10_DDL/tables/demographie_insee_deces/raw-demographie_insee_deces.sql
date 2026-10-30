CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.demographie_insee_deces (

    NM_NOM_PATIENT                     STRING   COMMENT 'Nom nom patient',
    NM_PRENOM_PATIENT                  STRING   COMMENT 'Nom prenom patient',
    NM_SEXE                            STRING   COMMENT 'Nom sexe',
    DT_NAISSANCE                       STRING   COMMENT 'Date naissance',
    CD_LIEU_NAISSANCE                  STRING   COMMENT 'Code lieu naissance',
    NM_VILLE                           STRING   COMMENT 'Nom ville',
    NM_PAYS                            STRING   COMMENT 'Nom pays',
    DT_DECES                           STRING   COMMENT 'Date deces',
    CD_LIEU_DECES                      STRING   COMMENT 'Code lieu deces',
    NB_ACTE_DECES                      STRING   COMMENT 'Nombre acte deces'

)

COMMENT 'Table externe RAW demographie_insee_deces'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/demographie/insee/deces'

;
