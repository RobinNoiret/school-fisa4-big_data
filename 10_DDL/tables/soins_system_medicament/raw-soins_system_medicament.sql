CREATE EXTERNAL TABLE IF NOT EXISTS chu_raw.soins_system_medicament (

    ID_TECH                            INT  COMMENT 'Identifiant technique',
    CD_CIS                             STRING   COMMENT 'Code CIS',
    NM_MEDICAMENT                      STRING   COMMENT 'Nom medicament',
    TXT_FORME_PHARMA                   STRING   COMMENT 'Texte forme pharmaceutique',
    TXT_VOIES_ADMINISTRATION           STRING   COMMENT 'Texte voies administration',
    TXT_STATUT_ADMIN                   STRING   COMMENT 'Texte statut administratif',
    TXT_TYPE_PROCEDURE                 STRING   COMMENT 'Texte type procedure',
    FL_COMMERCIALISATION               BOOLEAN  COMMENT 'Indicateur commercialisation',
    DT_AMM                             DATE     COMMENT 'Date AMM',
    TXT_STATUT_BDM                     STRING   COMMENT 'Texte statut bdm',
    CD_AUTORISATION_EURO               STRING   COMMENT 'Code autorisation europeenne',
    NM_TITULAIRE                       STRING   COMMENT 'Nom titulaire',
    FL_SURVEILLANCE_RENFORCEE          BOOLEAN  COMMENT 'Indicateur surveillance renforcee'

)

COMMENT 'Table externe RAW soins_system_medicament'

ROW FORMAT DELIMITED FIELDS TERMINATED BY ';'
STORED AS TEXTFILE
LOCATION '/user/cloudera/chu_dataplatform/raw/soins/system/medicaments'

;
