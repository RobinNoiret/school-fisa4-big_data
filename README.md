# CHU — Data Platform | Livrable 2

Ce dépôt regroupe les scripts, les traitements et les résultats techniques du projet Big Data du groupe CHU.

## Objectifs

- Implémenter les tables et les flux définis dans le livrable 1
- Intégrer les données issues des différentes sources
- Alimenter le modèle décisionnel en dimensions et tables de faits
- Mesurer la complétude, la cohérence et l’unicité des données
- Comparer les performances avant et après optimisation
- Fournir les éléments nécessaires pour reproduire les traitements

## Organisation du Data Lake

Le Data Lake est organisé en trois couches :

| Couche | Contenu |
|---|---|
| `raw` | Données intégrées après les premières opérations techniques |
| `refined` | Données nettoyées, harmonisées et contrôlées |
| `dwh` | Tables de dimensions et de faits destinées à l’analyse |

Dans les couches RAW et REFINED, les chemins suivent la convention :

`/<couche>/<source>/<activite>/<flux>/`

Exemples :

- `/raw/system/soins/hospitalisation/`
- `/refined/system/soins/hospitalisation/`
- `/raw/insee/demographie/deces/`

La couche DWH est organisée par type et par table. Les dimensions communes sont regroupées dans un espace partagé.
