# NLP Analysis Summary
## Punishment Study 2.1.2 - Facade Detection Analysis

**Date:** January 2026  
**N =** 496 valid responses

---

## Executive Summary

The NLP analysis tested whether people high on "dark" psychological factors (hostile aggression, hatred, revenge, SDO) use prosocial language to justify their punitive attitudes—what we termed the "prosocial facade" hypothesis. 

**Key Finding:** We found **no evidence of an individual-level prosocial facade**. People high on hostile aggression do NOT use more prosocial language than others. If anything, more punitive individuals use *less* prosocial language and more negative sentiment.

**However**, we discovered a **collective prosocial facade**: While people *claim* deterrence as their primary justification (85%), their actual language is semantically closer to revenge and suffering. This suggests the facade operates at a cultural/normative level rather than an individual-psychological level—everyone uses socially acceptable vocabulary while expressing darker content.

---

## Methods

### Text Data
Two open-ended questions following the sentencing task:
1. "Please explain why you recommended this sentence"
2. "What do you hope this sentence will accomplish?"

### Analysis Approaches

| Method | Tool | Purpose |
|--------|------|---------|
| Sentiment Analysis | VADER | Overall emotional tone |
| Dictionary-Based | Empath + Custom | Count prosocial/dark words |
| Zero-Shot Classification | BART-large-mnli | Categorize stated justifications |
| Semantic Similarity | all-mpnet-base-v2 | Compare to prototype sentences |
| Topic Modeling | BERTopic | Discover emergent themes |
| Visualization | UMAP | Embedding space exploration |

### Prototype Sentences
We created 3 exemplar sentences for each justification category:

**Prosocial Prototypes:**
- *Deterrence*: "This sentence will deter others from committing similar crimes"
- *Incapacitation*: "Society is safer with this person behind bars"
- *Rehabilitation*: "Everyone deserves a second chance to become a better person"
- *Retribution*: "The offender deserves this punishment for their actions"

**Dark Prototypes:**
- *Revenge*: "He deserves to suffer for what he did"
- *Suffering*: "Let him rot and suffer behind bars"
- *Exclusion*: "He has no place in our society"

---

## Results

### 1. Individual-Level Facade Detection: NOT SUPPORTED

**Core Question:** Do high-hostile individuals use prosocial language to mask their motives?

| Correlation | r | p | Interpretation |
|-------------|---|---|----------------|
| Prosocial Language × Hostile Aggression | **-0.04** | .354 | No relationship |
| Prosocial Language × Hatred | -0.04 | .388 | No relationship |
| Prosocial Language × Punitiveness | **-0.13** | **.005** | More punitive = LESS prosocial |
| Prosocial Language × RWA | **-0.10** | **.032** | Higher RWA = LESS prosocial |

**Conclusion:** People's stated justifications **reflect** rather than **mask** their underlying psychology.

### 2. Dark Language DOES Align with Dark Psychology

| Correlation | r | p |
|-------------|---|---|
| Dark Language (zero-shot) × Punitiveness | **+0.29** | <.001 |
| Dark Language (zero-shot) × Hatred | **+0.19** | <.001 |
| Dark Language (zero-shot) × Hostile Aggression | **+0.14** | .002 |
| Dark Language (zero-shot) × RWA | **+0.15** | <.001 |
| Dark Words (dict) × Punitiveness | **+0.13** | .005 |
| Negative Sentiment × Punitiveness | **-0.19** | <.001 |

**Conclusion:** Language authentically reflects psychology. Those high on hostile factors use more dark/retributive language.

### 3. Collective Prosocial Facade: SUPPORTED

**What People SAY (Zero-Shot Classification):**

| Justification | % Endorsement |
|---------------|---------------|
| Deterrence & Prevention | **85.3%** (highest) |
| Proportional Justice | 79.6% |
| Societal Condemnation | 73.2% |
| Punishment & Suffering | 72.1% |
| Public Safety | 65.2% |
| Victim Closure | 59.3% |
| Revenge & Payback | 39.9% |
| Rehabilitation | 24.3% (lowest) |

**What People's Language MEANS (Semantic Similarity):**

| Prototype | Mean Similarity |
|-----------|-----------------|
| **Revenge** | **0.458** (highest) |
| Retribution | 0.449 |
| Suffering | 0.434 |
| Incapacitation | 0.393 |
| Exclusion | 0.369 |
| Deterrence | 0.366 |
| Rehabilitation | 0.346 (lowest) |

**Critical Finding:** 
- Mean similarity to prosocial prototypes: **0.388**
- Mean similarity to dark prototypes: **0.420**
- **67.5%** of responses are semantically closer to dark prototypes

### 4. Text Predicting Sentencing Behavior

| Text Feature | r with Sentence | p |
|--------------|-----------------|---|
| Rehabilitation language (zero-shot) | **-0.451** | <.001 |
| Negative sentiment (VADER) | **-0.219** | <.001 |
| Rehabilitation similarity | **-0.212** | <.001 |
| Revenge language (zero-shot) | **+0.291** | <.001 |
| Deterrence language (zero-shot) | **+0.215** | <.001 |
| Dark words (dictionary) | **+0.156** | <.001 |
| Dark similarity | **+0.109** | .015 |

**Key Insight:** Rehabilitation language is the strongest text predictor (r = -.45). Notably, deterrence language predicts *longer* sentences (+.22), suggesting it functions as retributive framing rather than genuine prevention reasoning.

### 5. Group Comparisons: High vs. Low Hostile Aggression

| Variable | Low Hostile | High Hostile | d | p |
|----------|-------------|--------------|---|---|
| Prosocial similarity | 0.391 | 0.385 | -0.07 | .411 |
| Dark similarity | 0.419 | 0.421 | +0.02 | .829 |
| Sentiment | -0.46 | -0.54 | -0.14 | .111 |
| Word count | 50.4 | 46.2 | -0.12 | .187 |

**No significant differences** in text features between groups.

### 6. Vignette Stability

| Vignette | Prosocial × Hostile r | Sentiment × Punitiveness r |
|----------|----------------------|---------------------------|
| Stranger Felony-Murder | -0.05 | -0.29 |
| Domestic Violence | -0.09 | -0.15 |
| Organized Crime | +0.03 | -0.13 |

Pattern is consistent across crime types.

---

## Theoretical Implications

### A. No Individual-Level Prosocial Facade
The hypothesis that high-hostile individuals specifically mask their motivations with prosocial language is **not supported**. If anything, more punitive/authoritarian individuals use *less* prosocial language.

### B. Evidence for a Collective/Cultural Prosocial Facade
While individuals don't strategically hide their motives, there appears to be a **normative prosocial facade** at the cultural level:
- People claim "deterrence" (85%) but semantically express "revenge" (67.5% closer to dark prototypes)
- This suggests people have internalized prosocial punishment discourse as the legitimate framing, but their actual reasoning aligns more with retributive content

### C. Language Authentically Reflects Psychology
People's text reveals their true orientations:
- Dark psychology → dark language → harsher sentences
- Rehabilitation language → shorter sentences
- The language doesn't lie, even if the explicit framing does

### D. Implications for the "Prosocial Justification" Literature
The academic and public discourse treats deterrence, incapacitation, and rehabilitation as the "real" reasons for punishment. Our findings suggest these may be post-hoc rationalizations. The underlying psychology is more retributive, and the language—when analyzed semantically rather than by explicit claims—reveals this.

---

## Files Generated

| File | Description |
|------|-------------|
| `punishment_212_nlp_features.csv` | Full dataset with ~80 NLP features |
| `nlp_facade_correlations.csv` | Text × psychology correlations |
| `nlp_sentence_correlations.csv` | Text → sentencing correlations |
| `nlp_group_comparisons.csv` | High vs. low hostile comparisons |
| `nlp_vignette_correlations.csv` | Patterns by crime type |
| `facade_correlation_matrix.csv` | Key facade correlations |
| `bertopic_topics.csv` | Topic modeling results |
| `facade_visualizations.png` | UMAP and distribution plots |
| `wordcloud_*.png` | Word clouds by group |
| `nlp_correlation_heatmap.png` | Text × psychology heatmap |

---

## Summary Table for Manuscript

| Hypothesis | Measure | Result | Supported? |
|------------|---------|--------|------------|
| Individual facade: High-hostile use prosocial language | sim_prosocial × hostile_agg | r = -.04 (ns) | **No** |
| Alternative: Language reflects psychology | zs_dark × punitiveness | r = .29*** | **Yes** |
| Alternative: Sentiment reflects psychology | vader × punitiveness | r = -.19*** | **Yes** |
| Collective facade: Claimed ≠ actual justification | Zero-shot vs. similarity | 85% claim deterrence; 67.5% closer to revenge | **Yes** |
| Language predicts behavior | rehab_zs × sentence | r = -.45*** | **Yes** |
