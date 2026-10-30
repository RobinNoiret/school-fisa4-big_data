CREATE TABLE IF NOT EXISTS chu_refined.nom_flux (

    id_source   STRING  COMMENT 'Identifiant dans le systeme source - cle logique',
    lb_exemple  STRING  COMMENT 'Libelle nettoye et harmonise',
    valeur      STRING  COMMENT 'Valeur provenant du systeme source',

    -- champs techniques
    fl_active   BOOLEAN COMMENT 'Indique si la ligne est active selon les regles du flux',
    nm_file     STRING  COMMENT 'Chemin HDFS du fichier RAW utilise pour le chargement',
    nm_provider STRING  COMMENT 'Nom du fournisseur des donnees'

)

COMMENT 'Table interne REFINED du flux nom_flux'
STORED AS ORC

LOCATION '/user/cloudera/chu_dataplatform/refined/activity/provider/flux'

TBLPROPERTIES (
    'project' = 'CHU Data Platform',
    'layer'   = 'refined',
    'flow'    = 'nom_flux'
);
