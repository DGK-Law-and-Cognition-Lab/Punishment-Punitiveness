# Methodology

This document provides expanded methodological detail beyond what fits in the paper itself.

---

## Theoretical Background

### The Prosocial Thesis

Public, legal, and academic discussions of criminal punishment converge on a small set of justifications, all of which are framed as serving prosocial goals:

1. **Retribution** — restoring moral balance, proportional desert
2. **Deterrence** — preventing future crime through credible threat
3. **Incapacitation** — protecting society from dangerous individuals
4. **Rehabilitation** — reforming offenders for reintegration
5. **Norm expression** — reinforcing shared social values

When ordinary people are asked why they support punishment, they overwhelmingly invoke these reasons. When officials, jurists, and scholars defend punitive policies, they invoke these reasons. The conventional view is that this stated motivation is also the operative motivation.

### Our Challenge

We treat the conventional view as an empirical hypothesis rather than a settled fact. We test whether the *psychological substrate* of punitiveness — the constructs that actually correlate with people's punitive choices — matches the *prosocial vocabulary* people use to justify those choices.

The two studies make this comparison from complementary angles:

- **Study 1** measures the substrate. It correlates 18 psychological constructs with a punitiveness composite, asking which ones drive the variance.
- **Study 2** measures the vocabulary. It applies five NLP methods to participants' open-ended explanations of their own sentencing choices, asking what themes their language reflects.

A coherence between substrate and vocabulary would support the prosocial thesis (people invoke prosocial reasons because prosocial concerns drive them). An incoherence — where vocabulary points one way and substrate points another — calls the prosocial thesis into question.

### The Three Accounts of Incoherence (If Found)

Anticipating that the substrate and vocabulary might diverge, we specified three accounts that could explain the divergence:

1. **Sincerity.** Prosocial vocabulary genuinely reflects prosocial concerns; people are using these words because they hold these motives.
2. **Individual facade.** Prosocial vocabulary masks dark motives; the most hostile individuals are also the heaviest users of prosocial language.
3. **Cultural default.** Prosocial vocabulary is the dominant available script for talking about punishment, regardless of psychology; almost everyone uses it.

The accounts make different empirical predictions, which we test in Study 2.

---

## Punitiveness as a Construct

We treat punitiveness as a **multi-faceted attitudinal construct** rather than a single behavioral outcome:

- **Attitudinal items** (8): support for harsher punishment in general, rejection of parsimony, support for three-strikes laws, support for life without parole, support for the death penalty
- **Behavioral proxy** (1): recommended sentence in a randomly assigned criminal vignette, *z*-scored within vignette to remove between-vignette severity differences

The 8-item attitudinal scale (α = .84) and the 9-item composite that adds the *z*-scored sentencing decision (α = .84) yield essentially the same conclusions throughout the paper. We use the 9-item composite as the primary punitiveness measure unless the analysis treats sentencing as the dependent variable, in which case we use the 8-item version (Step 1 predictor) to avoid circularity.

---

## The Correlate Inventory

Our 18 correlate constructs are organized into five clusters by theoretical kinship:

| Cluster | Constructs | Rationale |
|---------|------------|-----------|
| **Crime Concerns** | Crime rates, fear of crime | Prosocial concerns about safety |
| **Emotions toward criminals** | Hatred, anger | Affective responses to wrongdoing |
| **Hostile aggression** | Exclusion, degradation, suffering, prison violence tolerance, harsh conditions, revenge | Hostile dispositions toward offenders |
| **Personality & ideology** | RWA, SDO, vengefulness, violence proneness, racial resentment, blood sports | Trait-level dispositions related to dominance, aggression, and out-group hostility |
| **Process violations (exploratory)** | Due process, willingness to convict on uncertain evidence | Endorsement of cutting procedural corners |

The cluster structure is theoretical, not data-driven; we test each cluster's overall correlation with punitiveness and also report each construct's individual correlation.

### Where the Constructs Come From

Three personality constructs use established scales verbatim:
- **Right-wing authoritarianism** (Bizumic & Duckitt, 2018)
- **Social dominance orientation** (Ho et al., 2015, SDO₇ short form)
- **Racial resentment** (Kinder & Sanders, 1996)

Six constructs were developed for the present study because we could find no prior measure for them in the punitiveness literature: willingness to convict on uncertain evidence, hatred toward offenders, infliction of suffering, tolerance of prison violence, violence proneness, and blood sports viewership. Item wording for all measures appears verbatim in the supplementary materials (S1).

---

## Sampling

We used **Prolific's Politically Representative US Sample**, which balances on age, sex, ethnicity, and political affiliation. The preregistered N was 480; we collected 538 to accommodate exclusions and retained 496 after excluding incomplete responses (n = 8) and attention-check failures (n = 34).

The political composition of the retained sample (38.3% liberal, 23.4% moderate, 38.3% conservative) reflects the active balancing on political affiliation, not chance.

---

## Vignettes

Each participant was randomly assigned to one of three sentencing vignettes, all involving a man named "Darryl Smith" convicted of second-degree murder:

1. **Stranger Felony-Murder** — failed purse-snatching turned fatal (n = 168)
2. **Domestic Violence Murder** — restraining-order violation turned fatal (n = 176)
3. **Organized Crime Murder** — assault during a car-theft operation (n = 152)

Participants were told judges typically sentence 20–30 years for the offense and could recommend 0–50 years. The sentencing scale is integer-valued; participants showed strong round-number anchoring (86% of responses concentrated on six values: 50, 30, 25, 40, 20, 35) and a substantial ceiling effect (32% chose the maximum 50 years).

To remove between-vignette severity differences, sentencing decisions are *z*-scored within vignette before entering any composite or analysis.

---

## Why Five NLP Methods, Not One

Single-method NLP findings are vulnerable to method artifacts. To make findings credible, we run **five conceptually different methods** and look for convergence:

1. **Dictionary classifier** — transparent, reproducible, hand-built. Captures lexical content.
2. **Zero-shot DeBERTa** — supervised, contextual. Reads pragmatic and discourse cues that lexical methods miss.
3. **Forced-choice Claude (Haiku 4.5)** — large language model with general semantic competence. Highest validation accuracy (100% on the 40-sentence ground-truth set).
4. **Embedding similarity** — continuous, fine-grained measure of semantic proximity to prototype sentences. Run with three models (BGE, voyage-3, MPNet) and five prototype variants for sensitivity.
5. **BERTopic** — unsupervised; clusters discover topics rather than imposing them.

The five methods agree on the gross pattern (prosocial themes dominate at 71–96%) and disagree only on detail (which prosocial theme dominates depends on the granularity of the labels). This kind of cross-method convergence is what we use to license substantive claims.

---

## Why Three Embedding Models

Sentence embeddings are sensitive to (a) the wording of the prototype sentences and (b) the choice of embedding model. The prototype sensitivity is addressed with five variants of the prototype set; the model sensitivity is addressed by running three independently trained models:

| Model | Trained On | Architecture |
|-------|------------|--------------|
| **BGE-large-en-v1.5** (BAAI) | Mixed retrieval-oriented corpus | BERT-style, 1024-dim |
| **voyage-3-large** (Voyage AI) | Recent semantic search corpus | Proprietary, 1024-dim |
| **Sentence-MPNet-base-v2** (Microsoft) | Community Q&A and forum data | MPNet, 768-dim |

A finding that holds in all three models (across independently trained data and different architectures) is more robust than one that holds only in the model that happened to be selected. The headline rehabilitation-suppression result is *r* = -.37 (BGE), *r* = -.35 (voyage), *r* = -.31 (MPNet) — same direction, similar magnitude, all three.

---

## Validation: 40-Sentence Ground-Truth Set

To benchmark classifier accuracy in a concrete way, we constructed a 40-sentence ground-truth set: 10 unambiguous sentences for each of four core themes (deterrence, rehabilitation, retribution, revenge). The sentences were written to be clearly diagnostic of their theme — e.g., for revenge: "He deserves to suffer the way his victim suffered."

Each classifier was scored on top-1 accuracy:

| Classifier | Top-1 Accuracy |
|-----------|----------------|
| Claude Haiku 4.5 (forced-choice) | 100.0% |
| DeBERTa-v3-large (zero-shot) | 87.5% |
| BART-MNLI (legacy, retired) | 77.5% |

The BART-MNLI classifier was used in our preliminary pipeline but retired from the manuscript pipeline due to its substantially lower accuracy.

---

## What We Don't Claim

- **Causality**: All analyses are correlational. We do not claim that hostile aggression causes punitiveness; only that they covary, to a degree, far in excess of crime concerns.
- **Strategic concealment**: Although two of six gap measures returned individual-facade verdicts (Claude ML, DeBERTa ML), we are cautious about reading these as evidence of *strategic* concealment. They are consistent with the cultural-default-with-selective-suppression interpretation we ultimately adopt — high-hostile individuals avoid the rehabilitation theme, which most classifiers code as prosocial; this attenuates their prosocial-dark gap without requiring deliberate masking.
- **Universal claims about punishment**: Our sample is U.S. adults. The cultural-default interpretation is, by hypothesis, *cultural* — meaning the rhetorical script is shaped by the discourse environment participants live in. Replication in other discourse environments (e.g., Scandinavian penal welfare contexts) would test this hypothesis directly.
