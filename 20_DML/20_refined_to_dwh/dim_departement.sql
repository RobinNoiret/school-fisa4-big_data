-- REFINED -> DWH | dim_departement

WITH departement_source AS (
    SELECT DISTINCT UPPER(TRIM(CD_DEPARTEMENT)) AS CD_DEPARTEMENT,
           UPPER(TRIM(NM_PAYS)) AS NM_PAYS
    FROM chu_refined.soins_system_patient
    WHERE FL_ACTIVE = TRUE AND CD_DEPARTEMENT IS NOT NULL AND TRIM(CD_DEPARTEMENT) <> ''
      AND NM_PAYS IS NOT NULL AND TRIM(NM_PAYS) <> ''
)

INSERT OVERWRITE TABLE chu_dwh.dim_departement (
    ID_DIM_DEPARTEMENT,
    CD_DEPARTEMENT,
    FK_DIM_PAYS
)

SELECT ROW_NUMBER() OVER (ORDER BY src.CD_DEPARTEMENT, src.NM_PAYS),
       src.CD_DEPARTEMENT,
       pays.ID_DIM_PAYS
    FROM departement_source src
INNER JOIN chu_dwh.dim_pays pays ON pays.NM_PAYS = src.NM_PAYS;
