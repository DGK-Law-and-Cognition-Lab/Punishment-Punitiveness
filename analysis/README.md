# Analysis Directory

## Analysis Scripts

| Script | Purpose | Requires |
|--------|---------|----------|
| `r/Punishment_2_1_2_Final_Script.Rmd` | Main confirmatory analysis (H1, H2, H3), reliability, regression, EFA/CFA | Raw data |
| `r/Punishment_2_1_2_Supplementary_Analyses.Rmd` | Bootstrap CIs, political moderation, simple slopes | `punishment_212_cleaned_data.csv` |
| `r/Punishment_2_1_2_Supplementary2_0.Rmd` | Tautology sensitivity, TOST equivalence, CFA validation | `punishment_212_cleaned_data.csv`, `punishment_212_nlp_features.csv` |
| `r/Punishment_2_1_2_Parsimony_Analysis.Rmd` | Item-level analysis of low-reliability parsimony scale | `punishment_212_cleaned_data.csv` |
| `r/Punishment_2_1_2_NLP_Integration.Rmd` | NLP features × psychological measures, facade detection | `punishment_212_nlp_features.csv` |
| `python/Punishment_212_NLP_Analysis.ipynb` | Full NLP pipeline (sentiment, dictionaries, zero-shot, embeddings, BERTopic) | `punishment_212_cleaned_data.csv` |

## Analysis Workflow

```
1. Final_Script.Rmd → punishment_212_cleaned_data.csv + main outputs
2. Supplementary_Analyses.Rmd → bootstrap CIs, political moderation
3. Supplementary2_0.Rmd → tautology tests, equivalence testing, CFA
4. Parsimony_Analysis.Rmd → parsimony item-level results
5. NLP_Analysis.ipynb (Python/Colab) → punishment_212_nlp_features.csv
6. NLP_Integration.Rmd → facade detection, text × psychology
```

## Output Files

### Tables (`output/tables/`)
~45 CSV files containing all statistical results. Key files:

| File | Description |
|------|-------------|
| `H1_punitiveness_correlations.csv` | Primary H1 results with FDR correction |
| `steiger_by_punitiveness_measure.csv` | H2 Steiger's Z by measure |
| `tautology_sensitivity_steiger.csv` | H2 after removing overlapping items |
| `tost_equivalence_results.csv` | Equivalence tests for null NLP correlations |
| `nlp_facade_correlations.csv` | Text × psychology correlations |

### Figures (`output/figures/`)
~18 PNG visualizations including heatmaps, distributions, word clouds, and UMAP plots.

## Required R Packages

```r
install.packages(c(
  "tidyverse", "psych", "corrplot", "Hmisc", "cocor",
  "lme4", "lmerTest", "car", "effectsize", "ggcorrplot",
  "knitr", "broom", "lavaan", "boot", "interactions",
  "performance", "RColorBrewer", "scales", "TOSTER"
))
```
