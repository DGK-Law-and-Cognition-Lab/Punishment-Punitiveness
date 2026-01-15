# Analysis Plan

## Punishment Study 2.1.2: Statistical Analysis Protocol

This document outlines the five-phase analysis approach for testing our pre-registered hypotheses about the psychological correlates of public punitiveness.

---

## Overview

### Pre-registered Hypotheses

| ID | Hypothesis | Analysis |
|----|------------|----------|
| H1 | Punitiveness will be positively correlated with all correlate measures | Pearson correlations with FDR correction |
| H2 | Hostile Aggression cluster will show stronger correlations with punitiveness than Crime Concerns cluster | Steiger's Z-test for dependent correlations |
| H3 | Most correlate measures will be positively intercorrelated | Full correlation matrix analysis |

### Analysis Software
- **R** (≥ 4.0) with tidyverse ecosystem
- **R Markdown** for reproducible reporting
- Key packages: `psych`, `cocor`, `Hmisc`, `lme4`, `lavaan`

---

## Phase 1: Data Preparation

### 1.1 Data Loading
```r
raw_data <- read.csv("Data_Final.csv", stringsAsFactors = FALSE)
```

### 1.2 Exclusion Criteria
Sequential filtering (pre-registered):

| Step | Criterion | Rationale |
|------|-----------|-----------|
| 1 | Progress = 100 | Complete survey only |
| 2 | Finished = 1 | Submitted responses |
| 3 | AttnCheck1 = 9 | Instruction following |
| 4 | AttnCheck2 = 4 | Basic arithmetic verification |

### 1.3 Missing Data Assessment
- Document missing values per variable
- Report any patterns of missingness
- Use listwise deletion for correlation analyses

---

## Phase 2: Construct Creation

### 2.1 Reverse Coding
25 items require reverse coding (scale: 1-7):

**Formula**: `reversed = 8 - original`

| Construct | Items to Reverse |
|-----------|------------------|
| Punitiveness | punishmore_1, parsimony_1, parsimony_2 |
| Emotions | hate_2 |
| Hostile Aggression | degrad_1, prisonvi_1, prisonvi_2, harsh_2 |
| Crime Concerns | fear_1 |
| RWA | rwa_3 |
| SDO | sdo_3, sdo_4, sdo_7, sdo_8 |
| Vengefulness | venge_1, venge_5 |
| Racial Resentment | Raceresent_1, Raceresent_4 |
| Due Process | dueprocess_2 |

### 2.2 Composite Score Creation

**Formula**: Simple mean of constituent items

```r
construct_comp <- rowMeans(df[, item_columns], na.rm = TRUE)
```

### 2.3 Cluster Aggregation

| Cluster | Constructs Included |
|---------|---------------------|
| Punitiveness | punishmore, parsimony, threestrikes, LWOP, death penalty, sentence (z-scored) |
| Crime Concerns | crime_rates, fear |
| Emotions | hatred, anger |
| Hostile Aggression | exclusion, degradation, suffering, prisonvi, harsh, revenge |
| Personality | RWA, SDO, vengefulness, violence proneness, racial resentment, blood sports |

### 2.4 Scale Reliability

Calculate Cronbach's α for each construct and cluster:

```r
alpha <- psych::alpha(df[, item_columns])$total$raw_alpha
```

**Acceptable threshold**: α ≥ .70 (note any below)

---

## Phase 3: Confirmatory Hypothesis Testing

### 3.1 H1: Punitiveness-Correlate Relationships

**Analysis**: Pearson correlations between punitiveness_agg and each correlate composite

```r
cor.test(punitiveness_agg, construct_comp, method = "pearson")
```

**Multiple comparison correction**: Benjamini-Hochberg FDR

```r
p_fdr <- p.adjust(p_values, method = "fdr")
```

**Criterion**: H1 supported if ≥90% of correlations are positive and significant after FDR

### 3.2 H2: Hostile Aggression vs. Crime Concerns

**Analysis**: Steiger's Z-test for comparing dependent correlations

```r
cocor::cocor.dep.groups.overlap(
  r.jk = cor(punitiveness, hostile_agg),
  r.jh = cor(punitiveness, crime_concerns_agg),
  r.kh = cor(hostile_agg, crime_concerns_agg),
  n = nrow(df)
)
```

**Criterion**: H2 supported if r(punitiveness, hostile) > r(punitiveness, crime) with p < .05

### 3.3 H3: Intercorrelations Among Correlates

**Analysis**: Full correlation matrix of all 16 correlate composites

```r
cor_matrix <- Hmisc::rcorr(as.matrix(correlate_df))
```

**Criterion**: H3 supported if >50% of correlations are positive

---

## Phase 4: Sensitivity Analyses

### 4.1 Cross-Vignette Stability

Compute correlations separately by vignette condition:

```r
df %>%
  group_by(vignette) %>%
  summarise(r = cor(punitiveness_agg, construct_comp))
```

Report correlation range across conditions.

### 4.2 Item-Level Correlations

Test each individual item against punitiveness (exploratory):

```r
item_cors <- sapply(item_columns, function(x) 
  cor.test(df$punitiveness_agg, df[[x]])$estimate)
```

### 4.3 Outlier Diagnostics

- Identify univariate outliers (>3 SD)
- Compute Mahalanobis distance for multivariate outliers
- Report sensitivity of results to outlier exclusion

### 4.4 Alternative Punitiveness Operationalizations

Compare results using:
1. Full composite (9 indicators + sentence)
2. Policy items only (8 items, no sentence)
3. Sentence only

---

## Phase 5: Advanced Modeling

### 5.1 Exploratory Factor Analysis

**Purpose**: Identify latent structure among correlates

```r
fa(correlate_matrix, nfactors = 4, rotate = "oblimin")
```

- Use scree plot and parallel analysis for factor retention
- Examine factor loadings and interpret

### 5.2 Multiple Regression

**Model 1**: All clusters predicting punitiveness
```r
lm(punitiveness_agg ~ crime_concerns_agg + emotions_agg + 
   hostile_agg + personality_agg)
```

**Model 2**: All constructs predicting punitiveness
```r
lm(punitiveness_agg ~ crime_rates + fear + hatred + anger + 
   exclusion + degradation + suffering + prisonvi + harsh + 
   revenge + rwa + sdo + venge + vprone + raceresent + bloodsports)
```

### 5.3 Hierarchical Regression

Test incremental variance explained:

| Step | Variables Added | Δ R² |
|------|-----------------|------|
| 1 | Crime Concerns | baseline |
| 2 | + Hostile Aggression | test H2 |
| 3 | + Emotions | additional variance |
| 4 | + Personality | full model |

### 5.4 Confirmatory Factor Analysis

**Model**: Four-factor structure (Crime Concerns, Emotions, Hostile, Personality)

```r
model <- '
  Crime =~ crime_rates_comp + fear_comp
  Emotions =~ hatred_comp + anger_comp
  Hostile =~ exclusion_comp + degradation_comp + suffering_comp + 
             prisonvi_comp + harsh_comp + revenge_comp
  Personality =~ rwa_comp + sdo_comp + venge_comp + vprone_comp + 
                 raceresent_comp + bloodsports_comp
'
cfa(model, data = df)
```

**Fit criteria**: CFI > .90, RMSEA < .08, SRMR < .08

### 5.5 Demographic Moderators (Exploratory)

Test if key relationships vary by:
- Political orientation (liberal vs. conservative)
- Gender
- Education level

---

## Output Files

### Tables

| File | Contents |
|------|----------|
| `reliability_alphas.csv` | Cronbach's α for all scales |
| `descriptive_statistics.csv` | Means, SDs, ranges |
| `H1_punitiveness_correlations.csv` | All correlations with punitiveness |
| `correlation_table_construct_level.csv` | Full correlation matrix |
| `vignette_correlation_stability.csv` | Cross-vignette consistency |

### Figures

| File | Contents |
|------|----------|
| `heatmap_construct_level.png` | Correlation heatmap |
| `heatmap_intercorrelations.png` | Correlate intercorrelations |
| `histogram_sentence.png` | Sentence distribution |
| `efa_scree_plot.png` | Factor analysis scree |

---

## Deviations from Pre-registration

Any deviations from the pre-registered analysis plan will be:
1. Documented in this section
2. Justified with rationale
3. Clearly labeled in results as "deviation from pre-registration"

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-10-01 | Initial pre-registration |
| 1.1 | 2025-12-15 | Added exploratory analyses |
| 1.2 | 2026-01-15 | Final analysis complete |
