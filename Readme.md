# Analyse de la convergence du PIB par habitant – COP27 (1950–2018)

## Objectif du projet

Ce projet en R vise à étudier **la convergence réelle des PIB par habitant** entre les pays de la COP27 sur la période de **1950 à 2018**.  
Nous explorons les notions de **β-convergence**, **σ-convergence**, **fonctions de densité**, ainsi que les **matrices de transition** paramétriques et non paramétriques pour évaluer les dynamiques de rattrapage ou de divergence économique.

---

## Structure du projet

convergence-cop27/
│
├── convergence_COP27.Rproj # Projet RStudio
├── data/ # Données utilisées (PIB par habitant, 1950–2018)
├── scripts/
│ ├── 01_density_estimation.R # Estimation des fonctions de densité
│ ├── 02_beta_convergence.R # Estimation de la β-convergence
│ ├── 03_sigma_convergence.R # Analyse de la σ-convergence
│ ├── 04_markov_parametrique.R # Matrices de transition paramétriques
│ └── 05_markov_nonparametrique.R # Matrices de transition non paramétriques (3D)
├── figures/ # Graphiques générés (densités, distributions, transitions)
└── README.md # Présentation du projet (ce fichier)

---

## Méthodologie

Le projet suit deux grands volets :

### 1. **Analyse de convergence**
- Étude des distributions de PIB par habitant des pays de la COP27
- Estimation **non paramétrique** des fonctions de densité
- Tests de **β-convergence** : régression du taux de croissance du PIB par tête
- Tests de **σ-convergence** : réduction de la dispersion inter-pays

### 2. **Analyse de la mobilité**
- Construction de **matrices de transition de Markov** pour mesurer la dynamique de mobilité des pays dans la distribution
- Comparaison des résultats obtenus via :
  - Estimation **paramétrique** (discrétisation des états)
  - Estimation **non paramétrique** (surface de densité 3D)

---

## Table des matières du rapport

1. **Introduction**  
2. I – Évolution de la distribution du PIB par tête  
3. II – La β-convergence  
4. III – La σ-convergence  
5. IV – Limites des fonctions de densité & σ-convergence  
6. V – Matrices de transition  
7. VI – Limites de l’estimation paramétrique  
8. VII – Estimation non paramétrique des matrices de mobilité  
9. **Conclusion**

---

## Résultats clés

- **Pas de rattrapage global** observé entre pays riches et pauvres via les approches paramétriques
- Les pays les plus riches ont tendance à le rester, les plus pauvres également
- En **horizon court terme (5 ans)** : faible mobilité, peu de convergence
- En **horizon moyen terme (10 ans)** : apparition de **clubs de convergence**
- L’approche **non paramétrique** révèle mieux les dynamiques fines de transition

---

## Outils utilisés

- **R**  
- Packages : `tidyverse`, `ggplot2`, `dplyr`, `np`, `expm`, `gganimate`, `plot3D`, `markovchain`, etc.

---

## Références théoriques

- Barro, Sala-i-Martin (1992, 1995)  
- Quah, D. (1993a, 1993b, 1996a)  
- J. Le Gallo (2004)

---

## Auteur

Projet réalisé par **Abderrahmane Boufares** et **Mehdi Ibrahim Assifar**
boufares11@gmail.com

---

## Remarque

Ce projet s’inscrit dans une approche académique visant à combiner rigueur économique et outils statistiques avancés pour explorer les dynamiques de croissance internationale dans une logique de convergence ou de polarisation.
