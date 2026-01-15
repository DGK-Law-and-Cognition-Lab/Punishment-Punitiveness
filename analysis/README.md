# Analysis Directory

This directory contains the analysis scripts and outputs for Punishment Study 2.1.2.

## Main Analysis

### `Punishment_2_1_2_Final_Script.Rmd`

The primary analysis script implementing the pre-registered analysis plan.

**To run:**
1. Open in RStudio
2. Update the data path to your local location (line 66)
3. Knit to HTML or run chunks sequentially

**Structure:**
- Phase 0: Setup and packages
- Phase 1: Data loading and filtering
- Phase 2: Reverse coding
- Phase 3: Construct creation
- Phase 4-6: Reliability and descriptives
- Phase 7: H1 testing (correlations)
- Phase 8: H2 testing (Steiger's Z)
- Phase 9: Exploratory analyses
- Phase 10: Multiple regression
- Phase 11: Output generation

### `Punishment_2_1_2_Final_Script.html`

Rendered output with all results, tables, and figures.

## Output Files

### Tables (`output/tables/`)

| File | Description |
|------|-------------|
| `H1_punitiveness_correlations.csv` | Primary hypothesis test results |
| `H1_item_level_correlations.csv` | Item-level correlations (exploratory) |
| `reliability_alphas.csv` | Cronbach's α for all scales |
| `descriptive_statistics.csv` | Means, SDs, ranges |
| `correlation_table_construct_level.csv` | Full correlation matrix |
| `correlation_table_intercorrelations.csv` | Correlate intercorrelations |
| `vignette_correlation_stability.csv` | Cross-vignette stability |
| `pvalues_construct_level.csv` | P-values for correlation matrix |

### Figures (`output/figures/`)

| File | Description |
|------|-------------|
| `heatmap_construct_level.png` | Main correlation heatmap |
| `heatmap_cluster_level.png` | Cluster-level correlations |
| `heatmap_intercorrelations.png` | Correlate intercorrelations |
| `histogram_sentence.png` | Distribution of sentences |
| `histogram_sentence_by_vignette.png` | Sentences by condition |
| `efa_scree_plot.png` | Factor analysis scree plot |

## Required Packages

```r
required_packages <- c(
  "tidyverse", "psych", "corrplot", "Hmisc", "cocor",
  "lme4", "lmerTest", "car", "effectsize", "ggcorrplot",
  "RColorBrewer", "knitr", "broom", "scales", "performance", "lavaan"
)
```

## Quick Results Access

```r
# Load key results
h1_results <- read.csv("output/tables/H1_punitiveness_correlations.csv")
reliability <- read.csv("output/tables/reliability_alphas.csv")
descriptives <- read.csv("output/tables/descriptive_statistics.csv")

# View top correlates
h1_results[order(-h1_results$r), c("Construct", "r", "sig_fdr")]
```
