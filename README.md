# The Dark Side of Punishment

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![OSF](https://img.shields.io/badge/OSF-Pre--registered-blue)](https://osf.io/kr7y2/overview?view_only=d312013b176a411c8cf6c126d7f54617)
[![R](https://img.shields.io/badge/R-%3E%3D4.0-276DC3?logo=r&logoColor=white)](https://www.r-project.org/)
[![Python](https://img.shields.io/badge/Python-3.10+-3776AB?logo=python&logoColor=white)](https://www.python.org/)

*Dan Simon (USC Gould School of Law), David E. Melnikoff (Stanford GSB), & David G. Kamper (UCLA Department of Psychology, University of Chicago Law School)*

---

## Overview

This repository contains the data, analysis code, materials, and manuscript for a two-study investigation of the psychological underpinnings of public punitiveness. We test whether the prosocial reasons people invoke when justifying punishment — deterrence, public safety, rehabilitation — are the actual psychological drivers of their punitive choices.

**Study 1** measures how 18 psychological constructs relate to punitiveness in 496 U.S. adults. **Study 2** applies a multi-method natural language processing pipeline to the open-ended sentencing justifications participants wrote at the end of Study 1, asking whether the prosocial language they reach for actually tracks the psychology that predicts their punitiveness.

### Headline Findings

> **Study 1.** Punitiveness is built largely of dark motivations. Hostile aggression measures (hatred, revenge, degradation, endorsement of suffering) correlated far more strongly with punitiveness (*r* = .59) than did legitimate crime concerns (*r* = .32), Steiger's *Z* = 6.26, *p* < .001. The advantage held under stringent tautology sensitivity tests at three levels of construct overlap.

> **Study 2.** Across five classification methods, 71%–96% of justifications were classified as prosocial. But of 33 cells in the text-feature × psychology matrix that reached both significance and a meaningful effect size, **32 were negative** — where text features tracked Study 1 psychology at all, they tracked it in the wrong direction.

> The most punitive participants did not endorse more revenge or suffering in their language. They specifically dropped one prosocial theme — **rehabilitation** — while continuing to invoke deterrence, incapacitation, and proportional justice at rates indistinguishable from low-hostile participants. We call this pattern a **cultural default with selective suppression**.

---

## Quick Access to Compiled Reports

| Report | Description |
|--------|-------------|
| **[Main Analysis](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/01_main_analysis.html)** | Study 1: H1–H3, descriptives, regressions, demographic moderation |
| **[NLP Integration](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/02_nlp_integration.html)** | Study 2: facade matrix, multiverse, hierarchical regressions |
| **[Supplementary Analyses](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/r/03_supplementary_analyses.html)** | Tautology, parsimony, CFA, TOST, sentence anchor, prototype sensitivity |
| **[NLP — Preprocessing & Dictionaries](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/python/01_preprocessing_and_dictionaries.html)** | Phase 1 of the Python NLP pipeline |
| **[NLP — Classification](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/python/02_classification.html)** | Phase 2: DeBERTa zero-shot, Claude forced-choice |
| **[NLP — Embeddings & Similarity](https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/analysis/python/03_embeddings_and_similarity.html)** | Phase 3: BGE, voyage, MPNet — five prototype sets, 45 combinations |

### Key Visualizations

| Figure | Description |
|--------|-------------|
| **[Cluster-Level Heatmap](analysis/output/figures/heatmap_cluster_level.png)** | Punitiveness × correlate-cluster correlations |
| **[Construct-Level Heatmap](analysis/output/figures/heatmap_construct_level.png)** | Punitiveness × all 18 constructs |
| **[Sentencing Distribution](analysis/output/figures/sentence_histogram_overall.png)** | Distribution of sentencing decisions vs. 25-year anchor |
| **[Sentencing by Vignette](analysis/output/figures/sentence_histogram_by_vignette.png)** | Per-vignette sentencing distributions |
| **[Facade Correlation Matrix](analysis/output/figures/facade_correlations_heatmap.png)** | Text features × psychological measures (99 cells) |
| **[UMAP Embeddings](analysis/output/figures/umap_three_models.png)** | Semantic space of justifications across three embedding models |
| **[Prototype Sensitivity](analysis/output/figures/prototype_sensitivity_master.png)** | Multiverse across 5 prototype sets × 3 embedding models |
| **[Cross-Method Convergence](analysis/output/figures/cross_method_convergence_heatmap.png)** | Pairwise agreement among five classifiers |
| **[Word Clouds by Hostile Tertile](analysis/output/figures/wordclouds_by_tertile.png)** | Lexical content by hostile-aggression group |
| **[TOST Equivalence](analysis/output/figures/tost_equivalence_plot.png)** | Equivalence testing for null facade correlations |

### Key Data Tables

| Table | Description |
|-------|-------------|
| **[H1 Correlations](analysis/output/tables/H1_punitiveness_correlations.csv)** | Punitiveness × each correlate, with FDR |
| **[Construct-Level Correlations](analysis/output/tables/correlation_table_construct_level.csv)** | Full construct correlation matrix |
| **[Reliability](analysis/output/tables/reliability_alphas.csv)** | Cronbach's α for all scales (8-item and 9-item punitiveness) |
| **[Descriptives](analysis/output/tables/descriptive_statistics.csv)** | Mean, SD, median for all composite measures |
| **[Demographic Moderation](analysis/output/tables/interactions_punitiveness_agg.csv)** | All 48 interaction tests, FDR-corrected |
| **[Tautology Sensitivity](analysis/output/tables/tautology_steiger_by_level.csv)** | H2 robustness across three stringency levels |
| **[Multiverse Verdicts](analysis/output/tables/mismatch_multiverse.csv)** | Six prosocial-dark gap measures vs. cultural-default/individual-facade/sincerity predictions |
| **[Facade Matrix](analysis/output/tables/facade_correlations_full.csv)** | All 99 text-feature × psychological-measure correlations |
| **[Cross-Method Convergence](analysis/output/tables/cross_method_convergence_5way.csv)** | Pairwise raw agreement and Cohen's κ |
| **[Prototype Sensitivity](analysis/output/tables/prototype_sensitivity_master.csv)** | All 45 prototype-set × embedding-model combinations |
| **[Hierarchical Regression](analysis/output/tables/regression_punitiveness_hierarchical.csv)** | Text features add ΔR² over Study 1 scales |

---

## Citation

```bibtex
@article{simon2026darkside,
  title = {The {{Dark Side}} of {{Punishment}}},
  author = {Simon, Dan and Melnikoff, David E. and Kamper, David G.},
  year = {2026},
  note = {Manuscript under review at the Journal of Personality and Social Psychology}
}
```

---

## Pre-Registered Hypotheses

| ID | Hypothesis | Status |
|----|------------|--------|
| **H1** | Punitiveness is positively correlated with all correlate measures | ✅ 16/18 sig under FDR |
| **H2** | The Hostile Aggression cluster correlates more strongly with punitiveness than the Crime Concerns cluster | ✅ *r* = .59 vs. *r* = .32; Steiger's *Z* = 6.26, *p* < .001 |
| **H3** | Most correlate measures are positively intercorrelated | ✅ 144 of 153 (94.1%) positive at *p* < .05 |

The pre-registration is publicly available at [OSF](https://osf.io/kr7y2/overview?view_only=d312013b176a411c8cf6c126d7f54617). All deviations from the pre-registration are documented in the supplementary materials.

---

## Study Design

### Participants
- **N = 496** US adults (recruited via Prolific from initial pool of 538)
- Used Prolific's **politically representative US sample**, balanced on age, sex, ethnicity, and political affiliation
- Resulting distribution: 38.3% liberal, 23.4% moderate, 38.3% conservative

### Punitiveness Aggregate
The composite (α = .84 for the 8-item attitudinal version; α = .84 with sentencing included as a 9th *z*-scored item) combines:
- Support for more punishment (2 items)
- Rejection of parsimony (2 items)
- Support for three-strikes laws (2 items)
- Support for life without parole (1 item)
- Support for the death penalty (1 item)
- Sentencing recommendation in a randomly assigned criminal vignette (within-vignette *z*-scored)

### Correlate Clusters

| Cluster | Constructs | Items |
|---------|------------|-------|
| **Crime Concerns** | Perceived crime rates, fear of crime | 5 |
| **Emotions Toward Criminals** | Hatred, anger | 5 |
| **Hostile Aggression** | Social exclusion, degradation, infliction of suffering, prison violence tolerance, harsh conditions, revenge | 16 |
| **Personality & Ideology** | RWA, SDO, vengefulness, violence proneness, racial resentment, blood sports viewership | 30 |
| **Process Violations (exploratory)** | Due process violations, willingness to convict on uncertain evidence | 7 |

### Sentencing Vignettes
Each participant was randomly assigned to one of three second-degree murder cases:
1. **Stranger Felony-Murder** (n = 168) — failed purse-snatching turned fatal
2. **Domestic Violence Murder** (n = 176) — restraining-order violation turned fatal
3. **Organized Crime Murder** (n = 152) — assault during a car-theft operation

Participants were told judges typically sentence 20–30 years; they could recommend 0–50 years and provide an open-ended justification. The open-ended responses are the input for Study 2.

---

## Study 2: NLP Pipeline

We characterize each justification using **five independent methods**:

1. **Dictionary classifier** — hand-built dictionaries for 5 prosocial and 5 dark themes
2. **Zero-shot DeBERTa-v3-large** — natural language inference over 8 candidate labels
3. **Forced-choice Claude (Haiku 4.5)** — single best-fitting label with confidence
4. **Embedding similarity** — cosine similarity to prototype sentences using **three** sentence-embedding models from different architectures and training corpora:
   - **BGE-large-en-v1.5** (BAAI)
   - **voyage-3-large** (Voyage AI)
   - **Sentence-MPNet-base-v2** (Microsoft)
5. **Topic modeling** — BERTopic on BGE embeddings + UMAP + HDBSCAN

### Multiverse Sensitivity Analyses

Embedding-based findings are tested across **5 prototype sets × 3 embedding models = 45 combinations** to verify robustness to:
- *Prototype wording* (formal legal, colloquial, lay-formal hybrid, anti-tautology variants)
- *Model architecture* (different training data, training objectives)

The headline rehabilitation-suppression result holds in all three embedding models (BGE *r* = -.37, voyage *r* = -.35, MPNet *r* = -.31 with punitiveness).

### Validation
Each classifier was validated against a 40-sentence ground-truth set. Top-1 accuracy:
- **Claude (forced-choice):** 100.0%
- **DeBERTa (zero-shot):** 87.5%
- *(BART-MNLI legacy classifier scored 77.5% and was retired from the pipeline.)*

---

## Repository Structure

```
Punishment-Punitiveness/
├── README.md                        # This file
├── LICENSE                          # MIT License
├── CITATION.cff                     # Citation metadata
├── CONTRIBUTING.md
│
├── data/
│   ├── raw/                         # Original Qualtrics export
│   │   └── Data_Final.csv
│   ├── processed/                   # Cleaned data
│   │   ├── punishment_212_cleaned_data.csv      # 496 × 145 (cleaned, pre-NLP)
│   │   └── punishment_212_nlp_features.csv      # 496 × 411 (with all NLP features)
│   ├── codebook/
│   │   ├── CODEBOOK.md              # Quantitative variables
│   │   └── NLP_CODEBOOK.md          # NLP-derived features
│   └── README.md
│
├── analysis/
│   ├── r/
│   │   ├── 01_main_analysis.Rmd            # Study 1: H1–H3, descriptives, demographics
│   │   ├── 02_nlp_integration.Rmd          # Study 2: facade matrix, multiverse, regressions
│   │   └── 03_supplementary_analyses.Rmd   # Tautology, parsimony, CFA, TOST, sentence anchor
│   ├── python/
│   │   ├── 01_preprocessing_and_dictionaries.ipynb
│   │   ├── 02_classification.ipynb         # DeBERTa + Claude
│   │   └── 03_embeddings_and_similarity.ipynb  # BGE + voyage + MPNet, multiverse
│   ├── output/
│   │   ├── tables/                  # ~64 CSV files
│   │   └── figures/                 # ~18 PNG files
│   └── README.md
│
├── manuscript/                      # LaTeX (apa7), targets JPSP
│   ├── main.tex                     # Compiles main.pdf
│   ├── supplementary.tex            # Compiles supplementary.pdf separately
│   ├── references.bib               # Shared bibliography
│   ├── OVERLEAF_SETUP.md            # How to compile both PDFs from one Overleaf project
│   ├── sections/
│   │   ├── introduction.tex
│   │   ├── study1.tex
│   │   ├── study2.tex
│   │   ├── general_discussion.tex
│   │   └── supplementary_body.tex
│   ├── tables/                      # 16 .tex files (tables and figure wrappers)
│   └── figures/                     # PNGs referenced by figure wrappers
│
├── materials/
│   ├── stimuli/                     # Qualtrics survey
│   ├── preregistration/             # Pre-reg document
│   └── README.md
│
└── docs/                            # Extended documentation
    ├── ANALYSIS_PLAN.md             # Pre-registered analysis plan
    ├── METHODOLOGY.md               # Methodological notes beyond what fits in the paper
    └── NLP_ANALYSIS_SUMMARY.md      # Plain-language NLP pipeline overview
```

---

## Quick Start

### R Analysis Requirements

```r
required_packages <- c(
  "tidyverse", "psych", "corrplot", "Hmisc", "cocor",
  "lme4", "lmerTest", "car", "effectsize", "ggcorrplot",
  "knitr", "broom", "lavaan", "boot", "interactions",
  "performance", "RColorBrewer", "scales", "TOSTER", "tidytext"
)
install.packages(required_packages)
```

### Python NLP Requirements

```python
# Python ≥ 3.10
pip install pandas numpy scikit-learn sentence-transformers \
            transformers torch bertopic umap-learn hdbscan \
            empath vaderSentiment anthropic voyageai
```

GPU is required for DeBERTa zero-shot classification (CPU runtime is prohibitive). The `02_classification.ipynb` notebook also calls the Anthropic API for the Claude forced-choice classifier and the Voyage AI API for `voyage-3-large` embeddings — both require API keys.

### Running the Pipeline

```bash
git clone https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness.git
cd Punishment-Punitiveness

# 1. Run the Python NLP pipeline (produces punishment_212_nlp_features.csv)
#    Each notebook can be opened in Jupyter or Google Colab
jupyter notebook analysis/python/01_preprocessing_and_dictionaries.ipynb
jupyter notebook analysis/python/02_classification.ipynb           # needs API keys
jupyter notebook analysis/python/03_embeddings_and_similarity.ipynb  # needs voyage key + GPU

# 2. Run the R analysis (consumes the NLP features CSV)
Rscript -e "rmarkdown::render('analysis/r/01_main_analysis.Rmd')"
Rscript -e "rmarkdown::render('analysis/r/02_nlp_integration.Rmd')"
Rscript -e "rmarkdown::render('analysis/r/03_supplementary_analyses.Rmd')"
```

The data file paths at the top of each `.Rmd` may need updating for your local environment.

---

## Pipeline Overview

### R: Phase Sequence

| Phase | Notebook | Purpose |
|-------|----------|---------|
| 1 | `01_main_analysis.Rmd` | Reverse coding, composites, reliability, descriptives |
| 2 | `01_main_analysis.Rmd` | H1 correlations + FDR; H2 Steiger Z; H3 intercorrelations |
| 3 | `01_main_analysis.Rmd` | Demographic moderation (48 tests); CFA |
| 4 | `02_nlp_integration.Rmd` | Facade matrix, multiverse verdicts, theme correlations |
| 5 | `02_nlp_integration.Rmd` | Hierarchical regressions (sentencing + punitiveness) |
| 6 | `03_supplementary_analyses.Rmd` | Tautology sensitivity, parsimony, TOST, sentence anchor |

### Python: Phase Sequence

| Phase | Notebook | Purpose |
|-------|----------|---------|
| 1 | `01_preprocessing_and_dictionaries.ipynb` | Text cleaning, VADER, Empath, hand-built dictionaries |
| 2 | `02_classification.ipynb` | DeBERTa zero-shot; Claude forced-choice + multi-label |
| 3 | `03_embeddings_and_similarity.ipynb` | BGE, voyage, MPNet embeddings × 5 prototype sets; BERTopic; UMAP |

---

## Reliability of Composite Measures

| Construct | α | N Items |
|-----------|---|---------|
| Punitiveness (8 attitudinal items) | .84 | 8 |
| Punitiveness (9 items, with sentencing) | .84 | 9 |
| Hostile Aggression cluster | .92 | 16 |
| Personality cluster | .92 | 30 |
| Emotions cluster | .85 | 5 |
| Crime Concerns cluster | .80 | 5 |
| RWA | .87 | 5 |
| SDO | .92 | 8 |
| Racial Resentment | .90 | 4 |
| Vengefulness | .88 | 5 |
| Parsimony* | .48 | 2 |
| Prison Violence Tolerance* | .56 | 2 |

*The parsimony and prison-violence scales fall below conventional thresholds. Both are flagged as caveats in the manuscript and supplementary materials. Item-level analyses (in `03_supplementary_analyses.Rmd`) confirm the same patterns hold across the parsimony scale's individual items.*

---

## Ethical Considerations

- **IRB Approval:** University of Southern California IRB (UP-21-00756, exempt status, minimal risk)
- **Informed Consent:** All participants provided informed consent
- **Anonymity:** No identifying information collected; Prolific IDs are used only to verify completion and were not retained in the analysis files
- **Sensitive Topics:** Items about race, crime, and punishment are unavoidable for this research question and were handled following standard guidelines

---

## Limitations

1. **Correlational design** — does not establish causal relationships
2. **Online sample** — Prolific participants are self-selected and may differ from the general population
3. **Self-report measures** — even with the NLP triangulation, both modalities are self-generated
4. **Single measurement occasion** — temporal stability is unknown
5. **Three vignettes, all second-degree murder** — generalization to other crime types is an open question
6. **Fixed survey order** — counterbalancing within blocks but not across them; potential order effects discussed in supplementary materials

---

## Authors

- **Dan Simon** — USC Gould School of Law and Department of Psychology
- **David E. Melnikoff** — Stanford Graduate School of Business
- **David G. Kamper** — Department of Psychology, UCLA, and University of Chicago Law School

## Contact

- Dan Simon: dsimon@law.usc.edu
- David G. Kamper: davidgkamper@ucla.edu

---

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file.

---

## Acknowledgments

- Prolific for participant recruitment
- USC IRB for ethical oversight
- All participants who contributed to this research

---

*This research challenges the assumption that criminal punishment is fundamentally prosocial by demonstrating its strong associations with hostile psychological factors, while documenting through computational text analysis that the prosocial vocabulary people use to justify their punishments operates as a cultural default — selectively suppressed, in one specific theme (rehabilitation), by those highest in punitive dispositions.*
