# NLP Analysis Summary

A plain-language overview of the natural language processing pipeline that produces Study 2's findings.

---

## The Question

After participants in Study 1 chose a sentence for the criminal vignette, they wrote, in their own words, why. Study 2 asks: **does the language people use to justify their punishments line up with the psychology that actually predicts those punishments?**

The Study 1 scales found that **hostile aggression** (hatred, revenge, degradation, suffering endorsement) predicts punitiveness about twice as strongly as **crime concerns** do. If language tracks psychology, the most punitive participants should sound more aggressive in their justifications. If language tracks the dominant cultural script for talking about punishment, almost everyone should sound prosocial regardless of psychology.

---

## What's in a Justification?

Participants wrote roughly 48 words on average (median 37, range 5–231). Examples from the corpus:

> "He took someone's life. He needs to be locked up so he can't hurt anyone else." *(public safety)*
> "Maybe with the right programs he could turn his life around. Prison alone doesn't fix anything." *(rehabilitation)*
> "He deserves to suffer the same way his victim suffered." *(revenge / suffering)*
> "Long sentences send a message that this kind of crime won't be tolerated." *(deterrence + norm expression)*

The pipeline aims to characterize each response along ten justification themes and then ask which themes correlate with which Study 1 measures.

---

## The Five Methods

We characterize each response in five different ways, then look for agreement across methods:

### 1. Dictionary Classifier (transparent, hand-built)

For each justification theme, we wrote a list of indicative words and phrases — "deserved to suffer," "suffer," "vengeance" for the revenge theme; "rehabilitation," "treatment," "second chance" for the rehabilitation theme. Each response is scored by the density of theme words in its text.

### 2. Zero-Shot DeBERTa (supervised, contextual)

DeBERTa-v3-large is a transformer model fine-tuned for natural language inference. We provide it with eight possible labels (deterrence, public safety, rehabilitation, proportional justice, condemnation, suffering, revenge, victim closure) and ask it to score how well each label applies to each response. The label with the highest score is the response's primary theme.

### 3. Claude Forced-Choice (LLM benchmark)

We send each response to Claude Haiku 4.5 with a structured prompt asking for the single best-fitting label and a confidence score. Claude is the most accurate of the supervised methods (100% on the validation set) because it can read pragmatic and discourse-level cues that simpler classifiers can't.

### 4. Embedding Similarity (continuous, fine-grained)

We use three sentence-embedding models — BGE, voyage-3, and Sentence-MPNet — to convert each response into a vector. We do the same for prototype sentences (one per theme) and measure cosine similarity between the response vector and each prototype vector. This gives a continuous score for "how much does this response sound like deterrence?" rather than a single forced-choice label.

We use **three** different models because embedding similarities are sensitive to the choice of model. A finding that replicates across three independently trained models is much stronger than one that depends on a single model.

We also use **five** different prototype sets (formal, colloquial, hybrid, anti-tautology, original) for the same reason — to make sure the result doesn't depend on the exact wording we chose for the prototypes.

That's 3 models × 5 prototype sets = 45 combinations of the embedding analysis.

### 5. BERTopic (unsupervised topic discovery)

BERTopic uses dimensionality reduction (UMAP) and clustering (HDBSCAN) to discover topics in the corpus without us specifying what to look for. The model finds 7 topic clusters; we then check whether topic distribution differs by political group or hostile-aggression tertile.

---

## What We Find

### The prosocial surface

Across all five methods, **71%–96%** of responses get classified as prosocial as their primary theme. No method puts dark themes over 30%. Whatever interpretation is right about the underlying psychology, the *language* people reach for is overwhelmingly prosocial.

### The mismatch

We construct a **99-cell matrix** of correlations between every text feature and every Study 1 psychological measure. Of the 33 cells that reach both significance and a meaningful effect size (|*r*| ≥ .10), **32 are negative**. Where text features track Study 1 psychology at all, they track it in the wrong direction.

### The single biggest effect

The strongest correlation in the entire matrix is **−.37**, linking BGE rehabilitation-similarity to punitiveness. The most punitive participants don't say more revenge or suffering things; they specifically say less rehabilitation things, while saying just as many deterrence, incapacitation, and proportional-justice things as everyone else.

### The multiverse verdicts

We compute six different versions of the prosocial-minus-dark gap and assign each a verdict. Four return "cultural default" (no reliable correlation with either hostile aggression or crime concerns). Two return "individual facade" (negative correlation with hostile aggression). None return "sincerity."

### The political stratification

The BERTopic analysis shows that liberals, moderates, and conservatives use the same set of themes in roughly the same proportions, despite large differences in punitiveness and hostile aggression. The rank order of topic frequencies is identical across political groups. The cultural default appears to be genuinely shared.

### The text features add prediction

Hierarchical regressions: when text features (BGE rehabilitation, BGE suffering, VADER sentiment, word count) are added to the Study 1 scales, R² jumps from .121 to .255 for predicting sentencing (ΔR² = .134) and from .428 to .507 for predicting punitiveness (ΔR² = .079). Language carries information that conventional self-report scales don't.

---

## What This Adds Up To

The pattern is best described as a **cultural default with selective suppression**: the prosocial vocabulary is widely shared across the political spectrum and across the hostility distribution, but the most hostile and punitive participants specifically attenuate one prosocial theme — rehabilitation — while continuing to invoke the others at normal rates.

This is not an "individual facade" in the strong strategic-concealment sense. We don't find positive correlations between dark-theme language and hostile measures, which a facade account would predict. What we find instead is that the prosocial script is the default vocabulary, but its rehabilitation component is selectively dropped by those with the most hostile dispositions toward offenders.

---

## Why This Matters Methodologically

Computational text analysis is increasingly common in psychology, but most published findings rest on single-classifier or single-prototype configurations. We make the cross-method and cross-configuration robustness explicit by running:

- **Five independent classifiers** that agree on the surface (prosocial dominance) but disagree on detail (which specific prosocial theme dominates)
- **45-combination embedding multiverse** showing that the rehabilitation-suppression result holds across three embedding models and five prototype variants
- **40-sentence ground-truth validation set** for top-1 accuracy benchmarking

By showing the full multiverse rather than picking the most striking result, we let readers see exactly where the conclusions are stable and where they vary with methodological choice.
