-- Creation de la BDD RAW

CREATE DATABASE IF NOT EXISTS chu_raw
    COMMENT 'Base de données RAW'
    LOCATION '/user/cloudera/chu_dataplatform'
    WITH DBPROPERTIES (
        'creator'='groupe_1',
        'created_at'='2026-10-30',
        'project'='CHU Data Platform',
        'layers'='raw'
    )
;
