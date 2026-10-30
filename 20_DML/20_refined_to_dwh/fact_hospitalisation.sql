-- REFINED -> DWH | fact_hospitalisation

WITH hospitalisation_source AS (
    SELECT ID_HOSPITALISATION,
           ID_PATIENT,
           TRIM(ID_ORIGANISATION) AS ID_ORGANISATION,
           UPPER(TRIM(CD_DIAGNOSTIC)) AS CD_DIAGNOSTIC,
           TRIM(DESC_DIAGNOSTIC) AS DESC_DIAGNOSTIC,
           TO_DATE(DT_ENTREE) AS DT_ENTREE,
           NB_JOUR
    FROM chu_refined.soins_system_hospitalisation
    WHERE FL_ACTIVE = TRUE AND ID_HOSPITALISATION IS NOT NULL AND DT_ENTREE IS NOT NULL AND NB_JOUR IS NOT NULL
),

hospitalisation_prepared AS (
    SELECT ID_HOSPITALISATION,
           ID_PATIENT,
           ID_ORGANISATION,
           CD_DIAGNOSTIC,
           DESC_DIAGNOSTIC,
           DT_ENTREE,
           DATE_ADD(DT_ENTREE, NB_JOUR) AS DT_SORTIE,
           NB_JOUR
    FROM hospitalisation_source
    WHERE DT_ENTREE IS NOT NULL AND NB_JOUR >= 0
)

INSERT OVERWRITE TABLE chu_dwh.fait_hospitalisation (
    ID_HOSPITALISATION,
    FK_DIM_TEMPS_ENTREE,
    FK_DIM_TEMPS_SORTIE,
    FK_DIM_PATIENT,
    FK_DIM_ETABLISSEMENT,
    FK_DIM_DIAGNOSTIC,
    NB_AGE_PATIENT,
    DUR_SEJOUR_JOUR,
    DESC_DIAGNOSTIC
)

SELECT src.ID_HOSPITALISATION,
       temps_entree.ID_DIM_TEMPS,
       temps_sortie.ID_DIM_TEMPS,
       patient.ID_DIM_PATIENT,
       etablissement.ID_DIM_ETABLISSEMENT,
       diagnostic.ID_DIM_DIAGNOSTIC,
       YEAR(src.DT_ENTREE) - patient.NB_ANNEE_NAISSANCE,
       src.NB_JOUR,
       src.DESC_DIAGNOSTIC
    FROM hospitalisation_prepared src
INNER JOIN chu_dwh.dim_temps temps_entree ON temps_entree.DT_JOUR = src.DT_ENTREE
INNER JOIN chu_dwh.dim_temps temps_sortie ON temps_sortie.DT_JOUR = src.DT_SORTIE
INNER JOIN chu_dwh.dim_patient patient ON patient.ID_PATIENT = src.ID_PATIENT
INNER JOIN chu_dwh.dim_etablissement etablissement ON etablissement.ID_ORGANISATION = src.ID_ORGANISATION
INNER JOIN chu_dwh.dim_diagnostic diagnostic ON diagnostic.CD_DIAGNOSTIC = src.CD_DIAGNOSTIC;
