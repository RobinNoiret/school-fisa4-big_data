CREATE TABLE IF NOT EXISTS chu_refined.soins_system_medicament (

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
    FL_SURVEILLANCE_RENFORCEE          BOOLEAN  COMMENT 'Indicateur surveillance renforcee',
    
    -- champs techniques
    fl_active                          BOOLEAN  COMMENT 'Ligne active',
    nm_file                            STRING   COMMENT 'Fichier source',
    nm_provider                        STRING   COMMENT 'Systeme source'

)

COMMENT 'Table interne REFINED soins_system_medicament'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/soins/system/medicaments'
;
