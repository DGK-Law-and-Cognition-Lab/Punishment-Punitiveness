# Is Criminal Punishment Prosocial?

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OSF](https://img.shields.io/badge/OSF-Pre--registered-blue)](https://osf.io/kr7y2/overview?view_only=d312013b176a411c8cf6c126d7f54617)
[![R](https://img.shields.io/badge/R-%3E%3D4.0-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Python-3.8+-3776AB?logo=python&logoColor=white)](https://www.python.org/)

**Investigating the Psychological Correlates of Public Punitiveness: Challenging the Prosocial Narrative of Criminal Punishment**

*David G. Kamper (UCLA), David E. Melnikoff (Stanford GSB), & Dan Simon (USC Gould School of Law)*

---

## Quick Access to Results

### Full Analysis Reports

| Report | Description |
|--------|-------------|
| **[Main Confirmatory Analysis](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/Punishment_2_1_2_Final_Script.html)** | Core hypothesis tests (H1–H3), reliability, regression |
| **[Supplementary Analyses](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/Punishment_2_1_2_Supplementary_Analyses.html)** | Bootstrap CIs, political moderation |
| **[Tautology & Sensitivity Analyses](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/Punishment_2_1_2_Supplementary2_0.html)** | Construct overlap tests, equivalence testing, CFA |
| **[Parsimony Follow-up](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/Punishment_2_1_2_Parsimony_Analysis.html)** | Item-level examination of low-reliability scale |
| **[NLP Analysis Pipeline](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/python/Punishment_212_NLP_Analysis.html)** | Text analysis on punishment justifications |
| **[NLP Integration Analysis](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/Punishment_2_1_2_NLP_Integration.html)** | Text analysis combined with psychological data |

### Key Visualizations

| Figure | Description |
|--------|-------------|
| **[Construct-Level Heatmap](analysis/output/figures/heatmap_construct_level.png)** | Correlations between punitiveness and all 16 constructs |
| **[Cluster-Level Heatmap](analysis/output/figures/heatmap_cluster_level.png)** | High-level view of cluster relationships |
| **[Intercorrelations](analysis/output/figures/heatmap_intercorrelations.png)** | Correlations among all correlate measures (H3) |
| **[Bootstrap H2 Distribution](analysis/output/figures/bootstrap_h2_distribution.png)** | Bootstrap CIs for Steiger's Z test |
| **[Facade Scatter Plot](analysis/output/figures/facade_scatter_plot.png)** | Hostile aggression vs. prosocial language |
| **[UMAP Embeddings](analysis/output/figures/UMAP.png)** | Semantic embedding space of justifications |
| **[TOST Equivalence](analysis/output/figures/tost_equivalence_plot.png)** | Equivalence testing for null facade correlations |

### Data Tables

| Table | Description |
|-------|-------------|
| **[H1 Results](analysis/output/tables/H1_punitiveness_correlations.csv)** | All punitiveness correlations with FDR correction |
| **[Reliability](analysis/output/tables/reliability_alphas.csv)** | Cronbach's α for all scales |
| **[Descriptives](analysis/output/tables/descriptive_statistics.csv)** | Means, SDs, ranges for all variables |
| **[Full Correlation Matrix](analysis/output/tables/correlation_table_construct_level.csv)** | Complete construct-level correlations |
| **[Steiger's Z Tests](analysis/output/tables/steiger_by_punitiveness_measure.csv)** | H2 test by punitiveness measure |
| **[Vignette Stability](analysis/output/tables/vignette_correlation_stability.csv)** | Cross-vignette correlation consistency |
| **[Tautology Sensitivity](analysis/output/tables/tautology_sensitivity_steiger.csv)** | H2 results after removing overlapping content |
| **[NLP Facade Correlations](analysis/output/tables/nlp_facade_correlations.csv)** | Text features × psychological measures |
| **[NLP Sentence Correlations](analysis/output/tables/nlp_sentence_correlations.csv)** | Text features predicting sentencing |

---

## Overview

This repository contains the data, analysis code, materials, and manuscript for a study examining the psychological drivers of criminal punitiveness. Our central thesis challenges the conventional academic and public discourse that frames criminal punishment as prosocially motivated (deterrence, rehabilitation, incapacitation, public safety), instead demonstrating that punitiveness correlates more strongly with darker psychological factors.

### Key Findings

> **Finding 1:** Public punitiveness is significantly more strongly associated with **hostile psychological factors** (hatred, revenge, support for harsh treatment) than with **legitimate crime concerns** (fear of crime, perceived crime rates), calling into question whether punishment attitudes are truly prosocially motivated.

> **Finding 2:** Text analysis of open-ended justifications reveals **no individual-level prosocial facade**—people high on hostile aggression do NOT strategically use more prosocial language. Instead, language authentically reflects underlying psychology.

> **Finding 3:** Despite this authenticity, a **collective prosocial facade** exists: 85% of participants claim deterrence as their primary justification, yet 67.5% of responses are semantically closer to revenge and suffering prototypes than to deterrence and rehabilitation.

---

## Citation

```bibtex
@article{kamper2026punishment,
  title = {Is Criminal Punishment Prosocial? Investigating the Psychological 
           Correlates of Public Punitiveness},
  author = {Kamper, David G. and Melnikoff, David E. and Simon, Dan},
  journal = {Law and Human Behavior},
  year = {2026},
  note = {Manuscript under review}
}
```

---

## Pre-registered Hypotheses

| Hypothesis | Description | Status |
|------------|-------------|--------|
| **H1** | Punitiveness will be positively correlated with all correlate measures | ✅ Supported |
| **H2** | Hostile Aggression cluster will show stronger correlations with punitiveness than Crime Concerns cluster | ✅ Supported |
| **H3** | Most correlate measures will be positively intercorrelated | ✅ Supported |

---

## Study Design

### Participants
- **N = 496** (after exclusions from initial 538)
- Recruited via Prolific
- US adult residents, balanced for age, ethnicity, and political affiliation

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
Three second-degree murder scenarios:
1. Stranger felony-murder
2. Domestic violence
3. Organized crime

### Open-Ended Justifications
Participants provided written explanations analyzed using:
- Sentiment analysis (VADER)
- Dictionary-based classification (Empath, custom dictionaries)
- Zero-shot classification (BART-large-mnli)
- Semantic similarity to prototype sentences (all-mpnet-base-v2)
- Topic modeling (BERTopic)
- UMAP visualization and clustering

---

## Key Results

### Correlations with Punitiveness (H1)

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

This finding is robust to:
- Removal of potentially overlapping items (tautology sensitivity)
- Alternative punitiveness operationalizations
- Bootstrap resampling (10,000 iterations)
- CFA-based latent variable approach

### Collective Prosocial Facade

| Measure | Finding |
|---------|---------|
| **Stated justification** | 85% endorse deterrence as primary motivation |
| **Semantic content** | 67.5% of responses closer to revenge/suffering than deterrence/rehabilitation |
| **Individual facade** | r = -.04 (ns) — no strategic masking |
| **Language reflects psychology** | Dark language × punitiveness: r = .29*** |

---

## Repository Structure

```
PunishmentPunitiveness/
├── README.md                        # This file
├── LICENSE                          # MIT License
├── CITATION.cff                     # Citation metadata
├── CONTRIBUTING.md                  # Contribution guidelines
├── .gitignore
│
├── data/
│   ├── raw/                         # Original data (not included; see note)
│   ├── processed/                   # Cleaned data files
│   │   ├── punishment_212_cleaned_data.csv
│   │   └── punishment_212_nlp_features.csv
│   ├── codebook/                    # Variable documentation
│   │   ├── CODEBOOK.md
│   │   └── NLP_CODEBOOK.md
│   └── README.md
│
├── analysis/
│   ├── r/                           # R analysis scripts
│   │   ├── Punishment_2_1_2_Final_Script.Rmd
│   │   ├── Punishment_2_1_2_Supplementary_Analyses.Rmd
│   │   ├── Punishment_2_1_2_Supplementary2_0.Rmd
│   │   ├── Punishment_2_1_2_Parsimony_Analysis.Rmd
│   │   └── Punishment_2_1_2_NLP_Integration.Rmd
│   ├── python/                      # Python NLP analysis
│   │   └── Punishment_212_NLP_Analysis.ipynb
│   ├── output/
│   │   ├── tables/                  # CSV outputs (~45 files)
│   │   └── figures/                 # PNG visualizations (~18 files)
│   └── README.md
│
├── materials/
│   ├── stimuli/                     # Survey instrument
│   │   └── PUNISHMENT_21_-__Pro-Social.docx
│   ├── preregistration/             # Pre-registration document
│   │   └── Punishment_2_1_2_--_Pre-registration__pro-social.docx
│   └── README.md
│
├── manuscript/                      # LaTeX manuscript (APA 7th)
│   ├── main.tex
│   ├── main.bbl
│   ├── references.bib
│   ├── sections/
│   ├── figures/
│   ├── tables/
│   └── README.md
│
└── docs/                            # Extended documentation
    ├── ANALYSIS_PLAN.md
    ├── METHODOLOGY.md
    └── NLP_ANALYSIS_SUMMARY.md
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

### Phase 4: Sensitivity & Robustness Analysis
- Bootstrap confidence intervals (10,000 iterations)
- Cross-vignette correlation stability
- Political moderation tests
- Tautology/construct overlap sensitivity testing
- TOST equivalence testing for null NLP correlations
- CFA-based latent variable approach

### Phase 5: Advanced Modeling
- Exploratory factor analysis
- Confirmatory factor analysis
- Multiple regression (clusters and constructs)
- Hierarchical regression (incremental R²)

### Phase 6: NLP Analysis (Python)
- Text preprocessing and cleaning
- Sentiment analysis (VADER)
- Dictionary-based classification (Empath, custom)
- Zero-shot classification (8 justification categories)
- Semantic similarity to prototype sentences
- Topic modeling (BERTopic)
- UMAP visualization and clustering

### Phase 7: NLP Integration (R)
- Merge NLP features with psychological measures
- Facade detection hypothesis tests
- Incremental validity analysis
- Text → sentencing behavior analysis

---

## Quick Start

### Requirements

**R Analysis:**
```r
required_packages <- c(
  "tidyverse", "psych", "corrplot", "Hmisc", "cocor",
  "lme4", "lmerTest", "car", "effectsize", "ggcorrplot",
  "knitr", "broom", "lavaan", "boot", "interactions",
  "performance", "RColorBrewer", "scales", "TOSTER"
)
install.packages(required_packages)
```

**Python NLP Analysis:**
- Python ≥ 3.8
- Google Colab (recommended) or local environment with GPU

### Running the Analysis

1. Clone the repository:
```bash
git clone https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness.git
cd Punishment-Punitiveness
```

2. **Main R Analysis:**
   - Open `analysis/r/Punishment_2_1_2_Final_Script.Rmd`
   - Update data path (line ~66)
   - Knit to HTML

3. **Supplementary Analyses:**
   - Run `Punishment_2_1_2_Supplementary_Analyses.Rmd` (bootstrap, political moderation)
   - Run `Punishment_2_1_2_Supplementary2_0.Rmd` (tautology, equivalence, CFA)
   - Run `Punishment_2_1_2_Parsimony_Analysis.Rmd` (low-reliability scale)

4. **NLP Analysis (Python):**
   - Upload `analysis/python/Punishment_212_NLP_Analysis.ipynb` to Google Colab
   - Set Runtime → GPU
   - Upload `data/processed/punishment_212_cleaned_data.csv`
   - Run all cells (~15–20 min)

5. **NLP Integration (R):**
   - Run `analysis/r/Punishment_2_1_2_NLP_Integration.Rmd`

---

## Scale Reliability

| Construct | α | N Items |
|-----------|---|---------|
| Punitiveness (8 items) | .84 | 8 |
| RWA | .87 | 5 |
| SDO | .92 | 8 |
| Vengefulness | .88 | 5 |
| Racial Resentment | .90 | 4 |
| Hostile Aggression Cluster | .92 | 16 |
| Personality Cluster | .92 | 30 |
| Parsimony* | .48 | 2 |

*Note: Parsimony scale showed low reliability; see supplementary analysis for item-level examination.*

---

## Ethical Considerations

- **IRB Approval:** USC IRB (exempt status, minimal risk)
- **Informed Consent:** All participants provided informed consent
- **Anonymity:** No identifying information collected
- **Sensitive Topics:** Questions about race, crime, and punishment handled with care

---

## Limitations

1. **Correlational design** — cannot establish causal relationships
2. **Online sample** — may not generalize to all populations
3. **Self-report measures** — subject to social desirability bias
4. **Single measurement occasion** — cannot assess temporal stability
5. **Text analysis limitations** — short responses may limit semantic analysis accuracy

---

## Authors

- **David G. Kamper** — UCLA Department of Psychology
- **David E. Melnikoff** — Stanford Graduate School of Business
- **Dan Simon** — USC Gould School of Law, Department of Psychology

## Contact

- Dan Simon: dsimon@law.usc.edu
- David G. Kamper: davidgkamper@ucla.edu

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- Prolific for participant recruitment
- USC IRB for ethical oversight
- All participants who contributed to this research

---

*This research challenges the assumption that criminal punishment is fundamentally prosocial by demonstrating its strong associations with hostile psychological factors. The NLP analysis reveals that while individuals don't strategically hide their motives, the cultural discourse of punishment operates through a collective prosocial facade—we talk about deterrence while meaning revenge.*
