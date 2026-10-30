-- REFINED -> DWH | dim_patient

WITH patient_source AS (
    SELECT ID_PATIENT,
           UPPER(TRIM(CD_SEXE)) AS CD_SEXE,
           DT_NAISSANCE AS NB_ANNEE_NAISSANCE,
           UPPER(TRIM(CD_GROUPE_SANGUIN)) AS CD_GROUPE_SANGUIN,
           UPPER(TRIM(NM_VILLE)) AS NM_VILLE,
           UPPER(TRIM(CD_DEPARTEMENT)) AS CD_DEPARTEMENT
    FROM chu_refined.soins_system_patient
    WHERE FL_ACTIVE = TRUE AND ID_PATIENT IS NOT NULL
)

INSERT OVERWRITE TABLE chu_dwh.dim_patient

SELECT
    ROW_NUMBER() OVER (ORDER BY src.ID_PATIENT) AS ID_DIM_PATIENT,
    src.ID_PATIENT AS ID_PATIENT,
    src.CD_SEXE AS CD_SEXE,
    src.NB_ANNEE_NAISSANCE AS NB_ANNEE_NAISSANCE,
    src.CD_GROUPE_SANGUIN AS CD_GROUPE_SANGUIN,
    ville.ID_DIM_VILLE AS FK_DIM_VILLE
FROM patient_source src
LEFT JOIN chu_dwh.dim_departement departement ON departement.CD_DEPARTEMENT = src.CD_DEPARTEMENT
LEFT JOIN chu_dwh.dim_ville ville ON ville.NM_VILLE = src.NM_VILLE
                                  AND ville.FK_DIM_DEPARTEMENT = departement.ID_DIM_DEPARTEMENT;
