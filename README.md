# Punishment - Punitiveness

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OSF](https://img.shields.io/badge/OSF-Pre--registered-blue)](https://osf.io/kr7y2/overview?view_only=d312013b176a411c8cf6c126d7f54617)
[![R](https://img.shields.io/badge/R-%3E%3D4.0-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Python-3.8+-3776AB?logo=python&logoColor=white)](https://www.python.org/)

**Investigating the Psychological Correlates of Public Punitiveness: Challenging the Prosocial Narrative of Criminal Punishment**

---

## Quick Access to Results

### Full Analysis Reports

| Report | Description |
|--------|-------------|
| **[Main Confirmatory Analysis](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/Punishment_2_1_2_Final_Script.html)** | Core hypothesis tests, reliability, regression |
| **[Supplementary Analyses](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/Punishment_2_1_2_Supplementary_Analyses.html)** | Bootstrap CIs, political moderation |
| **[NLP Integration Analysis](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/Punishment_2_1_2_NLP_Integration.html)** | Text analysis of punishment justifications |

### Key Visualizations

| Figure | Description | Link |
|--------|-------------|------|
| **Construct-Level Heatmap** | Correlations between punitiveness and all 16 constructs | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/heatmap_construct_level.png) |
| **Cluster-Level Heatmap** | High-level view of cluster relationships | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/heatmap_cluster_level.png) |
| **Intercorrelations** | Correlations among all correlate measures (H3) | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/heatmap_intercorrelations.png) |
| **Sentence Distribution** | Distribution of recommended sentences by vignette | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/histogram_sentence_by_vignette.png) |
| **EFA Scree Plot** | Factor analysis eigenvalues | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/efa_scree_plot.png) |
| **NLP Correlation Heatmap** | Text features × psychological measures | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/nlp_correlation_heatmap.png) |
| **Facade Scatter Plot** | Hostile aggression vs. prosocial language | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/facade_scatter_plot.png) |
| **Facade Visualizations** | UMAP embeddings and distributions | [View](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/facade_visualizations.png) |
| **Word Clouds** | High vs. low hostile aggression language | [All](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/wordcloud_all.png) / [High](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/wordcloud_high_hostile.png) / [Low](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/figures/wordcloud_low_hostile.png) |

### Data Tables

| Table | Description | Link |
|-------|-------------|------|
| **H1 Results** | All punitiveness correlations with FDR correction | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/H1_punitiveness_correlations.csv) |
| **Reliability** | Cronbach's α for all scales | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/reliability_alphas.csv) |
| **Descriptives** | Means, SDs, ranges for all variables | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/descriptive_statistics.csv) |
| **Full Correlation Matrix** | Complete construct-level correlations | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/correlation_table_construct_level.csv) |
| **Vignette Stability** | Cross-vignette correlation consistency | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/vignette_correlation_stability.csv) |
| **NLP Facade Correlations** | Text features × psychological measures | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/nlp_facade_correlations.csv) |
| **NLP Sentence Correlations** | Text features predicting sentencing | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/nlp_sentence_correlations.csv) |
| **BERTopic Topics** | Topic modeling results | [CSV](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/output/tables/bertopic_topics.csv) |

---

## Overview

This repository contains the data, analysis code, and materials for a multi-study research program examining the psychological drivers of criminal punitiveness. Our central thesis challenges the conventional academic and public discourse that frames criminal punishment as prosocially motivated (deterrence, rehabilitation, incapacitation, public safety), instead demonstrating that punitiveness correlates more strongly with darker psychological factors.

### Key Findings

> **Finding 1:** Public punitiveness is significantly more strongly associated with **hostile psychological factors** (hatred, revenge, support for harsh treatment) than with **legitimate crime concerns** (fear of crime, perceived crime rates), calling into question whether punishment attitudes are truly prosocially motivated.

> **Finding 2:** Text analysis of open-ended justifications reveals **no individual-level prosocial facade**—people high on hostile aggression do NOT strategically use more prosocial language. Instead, language authentically reflects underlying psychology.

> **Finding 3:** Despite this authenticity, a **collective prosocial facade** exists: 85% of participants claim deterrence as their primary justification, yet 67.5% of responses are semantically closer to revenge and suffering prototypes than to deterrence and rehabilitation.

---

## Citation

If you use this data, code, or materials in your research, please cite:

```bibtex
@article{simon2026punishment,
  title = {Is Punishment Prosocial? Investigating the Psychological Correlates of Public Punitiveness},
  author = {Simon, Dan and Kamper, David G.},
  journal = {Working Paper},
  year = {2026},
  institution = {University of Southern California, Gould School of Law; University of California, Los Angeles}
}
```

---

## Research Questions

1. **Is punishment truly prosocial?** We test whether public punitiveness correlates with prosocial concerns (crime rates, public safety) or darker psychological factors.

2. **What predicts punitiveness?** We examine correlations between punitiveness and 16+ psychological constructs across multiple domains.

3. **Is there a "punitiveness mindset"?** We test whether the various correlates of punitiveness are themselves intercorrelated, suggesting a coherent psychological profile.

4. **Do people hide their motives?** Using computational text analysis, we examine whether individuals high on dark psychology use prosocial language to mask their true motivations.

---

## Pre-registered Hypotheses

| Hypothesis | Description | Status |
|------------|-------------|--------|
| **H1** | Punitiveness will be positively correlated with all correlate measures | Supported |
| **H2** | Hostile Aggression cluster will show stronger correlations with punitiveness than Crime Concerns cluster | Supported |
| **H3** | Most correlate measures will be positively intercorrelated | Supported |

---

## Study Design

### Participants
- **N = 496** (after exclusions)
- Recruited via Prolific
- US adult residents
- Balanced gender distribution

### Punitiveness Measures
Our composite punitiveness construct (α = .84) includes:
- Support for more punishment (2 items)
- Rejection of parsimony principle (2 items)
- Support for three-strikes laws (2 items)
- Support for life without parole
- Support for death penalty
- Sentencing recommendation in vignette case

### Correlate Clusters

| Cluster | Constructs | Items |
|---------|------------|-------|
| **Crime Concerns** | Perceived crime rates, Fear of crime | 5 |
| **Emotions Toward Criminals** | Hatred, Anger | 5 |
| **Hostile Aggression** | Social exclusion, Degradation, Infliction of suffering, Prison violence tolerance, Support for harsh conditions, Revenge | 16 |
| **Personality** | RWA, SDO, Vengefulness, Violence proneness, Racial resentment, Blood sports viewership | 30 |

### Vignette Conditions
Three vignette conditions (second-degree murder scenarios) to enhance generalizability:
1. Stranger felony-murder
2. Domestic violence
3. Organized crime

### Open-Ended Justifications
Participants provided written explanations for their sentencing decisions, analyzed using:
- Sentiment analysis (VADER)
- Dictionary-based classification (Empath, custom dictionaries)
- Zero-shot classification (BART-large-mnli)
- Semantic similarity to prototype sentences (all-mpnet-base-v2)
- Topic modeling (BERTopic)
- UMAP visualization and clustering

---

## Key Results

### Correlations with Punitiveness

| Construct | r | Significance |
|-----------|---|--------------|
| Harsh prison conditions | .56 | *** |
| Social exclusion | .54 | *** |
| Hatred of criminals | .53 | *** |
| Infliction of suffering | .52 | *** |
| Right-wing authoritarianism | .50 | *** |
| Racial resentment | .46 | *** |
| Anger toward criminals | .45 | *** |
| Degradation | .44 | *** |
| Revenge | .43 | *** |
| Violence proneness | .41 | *** |
| Perceived crime rates | .40 | *** |
| Prison violence tolerance | .35 | *** |
| Social dominance orientation | .32 | *** |
| Fear of crime | .18 | ** |

### H2 Test: Hostile Aggression vs. Crime Concerns

```
r(Punitiveness, Hostile Aggression) = .61
r(Punitiveness, Crime Concerns)     = .34
Steiger's Z = 7.89, p < .001
```

**Conclusion:** Hostile psychological factors are significantly stronger correlates of punitiveness than crime concerns, contradicting the prosocial justification narrative.

### NLP Analysis: No Individual Facade, But a Collective One

#### Individual-Level Facade Detection

| Text Feature | × Hostile Aggression | p | Interpretation |
|--------------|---------------------|---|----------------|
| Prosocial similarity | r = -.04 | .354 | No relationship |
| Dark similarity | r = -.01 | .836 | No relationship |
| Sentiment | r = -.05 | .248 | No relationship |

**No evidence of individual-level masking.** People high on hostile aggression do NOT use more prosocial language.

#### Language Authentically Reflects Psychology

| Text Feature | × Punitiveness | × Hatred | × Hostile Agg |
|--------------|---------------|----------|---------------|
| Dark language (zero-shot) | .29*** | .19*** | .14** |
| Dark words (dictionary) | .13** | .05 | .08 |
| Negative sentiment | -.19*** | -.09* | -.05 |

**Language reveals, not conceals, underlying psychology.**

#### Collective Prosocial Facade

| Measure | Finding |
|---------|---------|
| **Stated justification** | 85% endorse deterrence as primary motivation |
| **Semantic content** | 67.5% of responses closer to revenge/suffering than deterrence/rehabilitation |
| **Mean similarity to prosocial** | 0.39 |
| **Mean similarity to dark** | 0.42 |

**Interpretation:** People use the socially acceptable vocabulary of deterrence while expressing content semantically aligned with revenge and suffering. The facade operates at the cultural level, not the individual strategic level.

#### Text Predicting Sentencing Behavior

| Text Feature | r with Sentence | Direction |
|--------------|-----------------|-----------|
| Rehabilitation language | **-.45***  | Shorter sentences |
| Negative sentiment | -.22*** | Shorter sentences |
| Revenge language | +.29*** | Longer sentences |
| Deterrence language | +.22*** | Longer sentences |
| Dark words | +.16*** | Longer sentences |

**Key insight:** Rehabilitation language is the strongest text predictor of sentencing. People who invoke rehabilitation recommend sentences nearly half a standard deviation shorter. Notably, deterrence language predicts *longer* sentences, suggesting it may function more as retributive framing than genuine crime prevention reasoning.

---

## Repository Structure

```
PunishmentPunitiveness/
├── README.md                 # This file
├── LICENSE                   # MIT License
├── CITATION.cff              # Citation metadata
├── CONTRIBUTING.md           # Contribution guidelines
│
├── data/
│   ├── raw/                  # Original data files
│   │   └── Data_Raw.csv
│   ├── processed/            # Cleaned and transformed data
│   │   ├── Data_Final.csv    # Slightly Cleaned
│   │   ├── punishment_212_cleaned_data.csv
│   │   └── punishment_212_nlp_features.csv
│   └── codebook/             # Variable documentation
│       ├── CODEBOOK.md
|       └── NLP_CODEBOOK.md
│
├── analysis/
│   ├── r/                    # R analysis scripts
│   │   ├── Punishment_2_1_2_Final_Script.Rmd
│   │   ├── Punishment_2_1_2_Final_Script.html
│   │   ├── Punishment_2_1_2_Supplementary_Analyses.Rmd
│   │   ├── Punishment_2_1_2_Supplementary_Analyses.html
│   │   ├── Punishment_2_1_2_Parsimony_Analysis.Rmd
│   │   ├── Punishment_2_1_2_Parsimony_Analysis.html
│   │   ├── Punishment_2_1_2_NLP_Integration.Rmd
│   │   └── Punishment_2_1_2_NLP_Integration.html
│   │
│   ├── python/               # Python NLP analysis
│   │   └── Punishment_212_NLP_Analysis.ipynb
│   │
│   └── output/               # Generated tables and figures
│       ├── tables/
│       │   ├── H1_punitiveness_correlations.csv
│       │   ├── H1_item_level_correlations.csv
│       │   ├── reliability_alphas.csv
│       │   ├── descriptive_statistics.csv
│       │   ├── correlation_table_construct_level.csv
│       │   ├── correlation_table_intercorrelations.csv
│       │   ├── pvalues_construct_level.csv
│       │   ├── vignette_correlation_stability.csv
│       │   ├── nlp_facade_correlations.csv
│       │   ├── nlp_group_comparisons.csv
│       │   ├── nlp_sentence_correlations.csv
│       │   ├── nlp_vignette_correlations.csv
│       │   ├── facade_correlation_matrix.csv
│       │   └── bertopic_topics.csv
│       │
│       └── figures/
│           ├── heatmap_construct_level.png
│           ├── heatmap_cluster_level.png
│           ├── heatmap_intercorrelations.png
│           ├── histogram_sentence.png
│           ├── histogram_sentence_by_vignette.png
│           ├── efa_scree_plot.png
│           ├── nlp_correlation_heatmap.png
│           ├── facade_scatter_plot.png
│           ├── facade_visualizations.png
│           ├── wordcloud_all.png
│           ├── wordcloud_high_hostile.png
│           └── wordcloud_low_hostile.png
│
├── materials/
│   ├── stimuli/              # Survey stimuli
│   │   └──PUNISHMENT_21_-__Pro-Social.docx
│   └── preregistration/      # Pre-registration documents
│       └──Punishment_2_1_2_--_Pre-registration__pro-social.docx
│
├── docs/
│   ├── ANALYSIS_PLAN.md      # Five-phase analysis approach
│   ├── METHODOLOGY.md        # Detailed methodological notes
│   └── NLP_ANALYSIS_SUMMARY.md  # NLP findings summary
│
└── manuscripts/
    └── drafts/               # Paper drafts (not for circulation)
```

---

## Analysis Pipeline

### Phase 1: Data Preparation
- Data loading and filtering
- Attention check exclusions (N = 496 final)
- Missing data assessment

### Phase 2: Construct Creation
- Reverse coding (25 items)
- Composite score calculation
- Scale reliability (Cronbach's α)

### Phase 3: Confirmatory Analysis
- H1: Correlation tests with FDR correction
- H2: Steiger's Z-test for dependent correlations
- H3: Intercorrelation analysis

### Phase 4: Sensitivity Analysis
- Bootstrap confidence intervals
- Cross-vignette correlation stability
- Political moderation tests
- Outlier diagnostics

### Phase 5: Advanced Modeling
- Exploratory factor analysis
- Multiple regression (clusters and constructs)
- Hierarchical regression (incremental R²)
- Confirmatory factor analysis

### Phase 6: NLP Analysis (Python)
- Text preprocessing and cleaning
- Sentiment analysis (VADER)
- Dictionary-based classification (Empath, custom)
- Zero-shot classification (8 justification categories)
- Semantic similarity to prototype sentences
- Topic modeling (BERTopic)
- UMAP visualization and clustering
- Facade detection correlations

### Phase 7: NLP Integration (R)
- Merge NLP features with psychological measures
- Facade detection hypothesis tests
- Incremental validity analysis
- Text → sentencing behavior analysis

---

## Quick Start

### Requirements

**R Analysis:**
- R ≥ 4.0
- RStudio (recommended)

```r
required_packages <- c(
  "tidyverse", "psych", "corrplot", "Hmisc", "cocor",
  "lme4", "lmerTest", "car", "effectsize", "ggcorrplot",
  "knitr", "broom", "lavaan", "boot", "interactions"
)
install.packages(required_packages)
```

**Python NLP Analysis:**
- Python ≥ 3.8
- Google Colab (recommended) or local environment with GPU

```python
# Key packages (installed in Colab notebook)
# transformers, sentence-transformers, bertopic,
# vaderSentiment, empath, umap-learn, wordcloud
```

### Running the Analysis

1. Clone the repository:
```bash
git clone https://github.com/DGK-Law-and-Cognition-Lab/PunishmentPunitiveness.git
cd PunishmentPunitiveness
```

2. **Main R Analysis:**
   - Open `analysis/r/Punishment_2_1_2_Final_Script.Rmd`
   - Update data path to your local path
   - Knit to HTML

3. **NLP Analysis (Python):**
   - Upload `analysis/python/Punishment_212_NLP_Analysis.ipynb` to Google Colab
   - Set Runtime → GPU
   - Upload `data/processed/punishment_212_cleaned_data.csv` when prompted
   - Run all cells (~15-20 minutes)
   - Download generated CSV files

4. **NLP Integration (R):**
   - Place NLP features CSV in working directory
   - Open `analysis/r/Punishment_2_1_2_NLP_Integration.Rmd`
   - Knit to HTML

---

## Scale Reliability

| Construct | Cronbach's α | N Items |
|-----------|--------------|---------|
| Punitiveness (8 items) | .84 | 8 |
| RWA | .87 | 5 |
| SDO | .92 | 8 |
| Vengefulness | .88 | 5 |
| Racial Resentment | .90 | 4 |
| Hostile Aggression Cluster | .92 | 16 |
| Personality Cluster | .92 | 30 |
| Parsimony* | .48 | 2 |

*Note: Parsimony scale showed low reliability; see supplementary analysis for item-level examination.

---

## Ethical Considerations

This research was conducted in accordance with ethical guidelines and approved by USC IRB. Key considerations:

- **Informed consent**: All participants provided informed consent
- **Anonymity**: No identifying information was collected
- **Sensitive topics**: Questions about race, crime, and punishment were handled with care
- **Response bias**: We acknowledge potential social desirability effects

---

## Limitations

1. **Correlational design**: Cannot establish causal relationships
2. **Online sample**: Results may not generalize to all populations
3. **Self-report measures**: Subject to social desirability bias
4. **Single measurement occasion**: Cannot assess temporal stability
5. **Text analysis limitations**: Short responses may limit semantic analysis accuracy

---

## Future Directions

- **Experimental studies**: Testing causal mechanisms through manipulation of justification framing
- **Cross-cultural replication**: Testing generalizability beyond US samples
- **Longitudinal design**: Assessing stability of punitiveness-correlate relationships
- **Qualitative deep dive**: Close reading of high-facade responses

---

## Authors

- **Dan Simon** - USC Gould School of Law, Department of Psychology
- **David G. Kamper** - UCLA Department of Psychology

## Contact

For questions about this research:
- Dan Simon: dsimon@law.usc.edu
- David G. Kamper: davidgkamper@ucla.edu

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Prolific for participant recruitment
- USC IRB for ethical oversight
- All participants who contributed to this research

---

*This research challenges the assumption that criminal punishment is fundamentally prosocial by demonstrating its strong associations with hostile psychological factors. The NLP analysis reveals that while individuals don't strategically hide their motives, the cultural discourse of punishment operates through a collective prosocial facade—we talk about deterrence while meaning revenge.*
