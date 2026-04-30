# Analysis Plan

This document describes the preregistered analysis plan for *The Dark Side of Punishment* and documents deviations from that plan in the published manuscript.

The full preregistration is on the Open Science Framework: <https://osf.io/kr7y2/>.

---

## Preregistered Hypotheses

| ID | Hypothesis | Test |
|----|------------|------|
| **H1** | Punitiveness is positively correlated with all correlate measures | Pearson correlations with FDR correction |
| **H2** | The Hostile Aggression cluster correlates more strongly with punitiveness than the Crime Concerns cluster | Steiger's *Z*-test for dependent correlations |
| **H3** | Most correlate measures are positively intercorrelated | Pairwise correlation matrix |

---

## Outcomes

| Variable | Definition |
|----------|------------|
| **Punitiveness aggregate** | Mean of *z*-scored: 8 attitudinal items (punish more, parsimony reversed, three strikes, LWOP, death penalty) + within-vignette *z*-scored sentencing decision |
| **Punitiveness 8-item** | Same as above but excludes the sentencing decision; used as Step 1 predictor when sentencing is the dependent variable |
| **Sentencing decision (z)** | Within-vignette *z*-score of recommended years (0–50) |

---

## Predictors

### Cluster Composites
- **Crime Concerns** (5 items): perceived crime rates + fear of crime
- **Hostile Aggression** (16 items): exclusion + degradation + suffering + prison violence tolerance + harsh conditions + revenge
- **Emotions** (5 items): hatred + anger
- **Personality & Ideology** (30 items): RWA + SDO + vengefulness + violence proneness + racial resentment + blood sports
- **Process Violations** (7 items, exploratory): due process + uncertain evidence

### Single-Construct Composites
Each of the constructs that make up the clusters is also analyzed as its own composite for the construct-level correlation matrix.

---

## Analysis Phases

### Phase 1 — Data Preparation
- Exclude incomplete responses (Progress < 100)
- Exclude attention-check failures
- Reverse-code marker items
- Compute composite scores
- Cronbach's α for all scales

### Phase 2 — Confirmatory Tests (H1, H2, H3)
- H1: Pearson *r* for punitiveness × each correlate, FDR-corrected
- H2: Steiger's *Z* comparing *r*(Punitiveness, Hostile Aggression) vs. *r*(Punitiveness, Crime Concerns)
- H3: Pairwise correlation matrix; count of significant positive *r*s

### Phase 3 — Robustness and Sensitivity
- Bootstrap BCa 95% CIs for the H2 difference
- Tautology sensitivity at three stringency levels (Original / Conservative / Strictest)
- Alternative punitiveness operationalizations (parsimony scale removed)
- Vignette stability (correlations within each vignette)
- Demographic moderation (48 interactions)
- Confirmatory Factor Analysis

### Phase 4 — NLP Analysis (Study 2)
- Five classifiers: dictionary, DeBERTa zero-shot, Claude forced-choice, embedding similarity (3 models), BERTopic
- 99-cell facade matrix (text features × psychological measures)
- Multiverse classifier verdicts (cultural-default vs. individual-facade vs. sincerity)
- Hierarchical regressions: Step 1 (Study 1 scales) → Step 2 (text features), for sentencing and for punitiveness
- 45-combination prototype × model sensitivity

---

## Deviations from Preregistration

The following deviations are documented transparently in the supplementary materials:

### 1. Embedding model expansion
The preregistration specified Sentence-MPNet for embedding-based similarity. We expanded to three models (BGE-large, voyage-3-large, Sentence-MPNet) to test the robustness of embedding-based findings to model choice. The preregistered MPNet-based analyses are still reported; the additional models are sensitivity tests. The headline rehabilitation-suppression finding holds in all three.

### 2. Prototype sensitivity expansion
The preregistration specified one set of prototype sentences. We added four additional sets (formal, colloquial, lay-formal, anti-tautology) as sensitivity tests. Findings reported in the main text use the original set; the multiverse appears in the supplementary materials.

### 3. Replacement of headline statistic
The preregistration anchored Study 2 on the proportion of responses semantically closer to dark than prosocial prototypes. Multiverse analysis showed this proportion is unstable across reasonable choices of prototype set and embedding model. We replaced the headline statistic with the **rehabilitation-suppression finding** (which replicates across all 45 combinations) and the **facade matrix asymmetry** (32 of 33 cells negative). Both are in the same conceptual family as the preregistered statistic but more robust.

### 4. Forced-choice Claude classifier added
The preregistration specified DeBERTa zero-shot as the supervised classifier. We added Claude Haiku 4.5 as a higher-accuracy reference point (validated at 100% top-1 vs. DeBERTa's 87.5%). Findings using DeBERTa are still reported; Claude is included as a benchmark.

### 5. Ground-truth validation set
The preregistration did not specify a validation procedure for the classifiers. We added a 40-sentence ground-truth set (10 per theme × 4 core themes) for top-1 accuracy reporting. This is a strengthening of the preregistration, not a contradiction.

---

## Effect Size Anchors

Where applicable, effect sizes are interpreted using these conventions:

| Magnitude | *r* | *d* | ΔR² |
|-----------|-----|-----|-----|
| Small | .10 | .20 | .01 |
| Medium | .30 | .50 | .09 |
| Large | .50 | .80 | .25 |

---

## Multiple Comparisons

- **H1**: Benjamini-Hochberg FDR across 18 correlate tests
- **H3**: Benjamini-Hochberg FDR across 153 pairwise correlations
- **Demographic moderation**: Benjamini-Hochberg FDR across all 48 interaction tests
- **NLP facade matrix**: 99 correlations reported; the central claim ("32 of 33 significant + meaningful cells were negative") is intentionally a sign-asymmetry test rather than per-cell inference, but per-cell *p*-values are in the supplementary table for reference
