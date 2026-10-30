-- Creation de la BDD DWH

CREATE DATABASE IF NOT EXISTS chu_dwh
    COMMENT 'Base de données DWH'
    LOCATION '/user/cloudera/chu_dataplatform'
    WITH DBPROPERTIES (
        'creator'='groupe_1',
        'created_at'='2026-10-30',
        'project'='CHU Data Platform',
        'layers'='dwh'
    )
;
