-- Creation de la BDD RFINED

CREATE DATABASE IF NOT EXISTS chu_refined
    COMMENT 'Base de données REFINED'
    LOCATION '/user/cloudera/chu_dataplatform'
    WITH DBPROPERTIES (
        'creator'='groupe_1',
        'created_at'='2026-10-30',
        'project'='CHU Data Platform',
        'layers'='refined'
    )
;
