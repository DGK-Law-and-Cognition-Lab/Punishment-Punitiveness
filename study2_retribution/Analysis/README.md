# Retribution Study — Analysis

**Two tracks. Two execution environments. Nothing else.**

| | **TRACK 1 — Closed-ended analysis** | **TRACK 2 — Open-ended language analysis** |
|---|---|---|
| **Environment** | **R Markdown (`.Rmd`), knitted to HTML** | **Google Colab notebooks (`.ipynb`)** |
| **Location** | `Analysis/Retribution R/` (the RStudio project) | `Analysis/NLP/colab/` |
| **Documents** | `01_main_analysis.Rmd`<br>`02_nlp_integration.Rmd`<br>`03_supplementary_analyses.Rmd` | `01_preprocessing_and_facets`<br>`02_llm_ensemble_scoring`<br>`03_embeddings_and_similarity`<br>`04_convergence_validation_export` |
| **Run it by** | Opening `Retribution R.Rproj` in RStudio and knitting the `.Rmd` | Opening the `.ipynb` in Colab and running top to bottom |
| **Covers** | H1–H21, E1–E2, cleaning, scoring, reliability, and the E3–E7 write-up | Facet extraction and scoring of the three open-ends |

**These are the only two execution environments in the pipeline. There are no
standalone `.R` scripts and no standalone `.py` scripts.** If you find yourself
about to write one, it belongs in an `.Rmd` chunk or a Colab cell instead.
`NLP/_superseded/` holds two local Python prototypes (see that folder's README)
and `Retribution R/_superseded/` holds the two `.R` scripts that
`01_main_analysis.Rmd` ports and supersedes, alongside their first-tranche
output. Both folders are provenance only — never import or run from them.

## How the two tracks connect

```
Data/FullData_Values.csv  (raw Qualtrics VALUES export, 1,015 responses)
        │
        ├──► TRACK 1  Retribution R/01_main_analysis.Rmd
        │        └─ writes  Retribution R/data/cleaned/retribution_scored.csv  (+ .rds)
        │                            │
        │                            ├──────────────► TRACK 2  NLP/colab/04  (upload: survey validators)
        │                            └──────────────► TRACK 1  02 and 03  (read it directly)
        │
        └──► TRACK 2  NLP/colab/01_preprocessing_and_facets
                 │        (builds openends_long.csv IN THE NOTEBOOK, Section 0.5)
                 ├─ 01 → facet_dictionary_scores.csv, gold_sample_template.csv,
                 │        gold_codes.csv, gold_split_assignment.csv
                 ├─ 02 → ensemble_facet_scores.csv, ensemble_agreement.csv
                 ├─ 03 → embedding_facet_similarity.csv
                 └─ 04 → convergence + triple gate + OSF bundle
                              │
                              ▼
                   download the CSVs into  NLP/outputs/
                              │
                              ▼
              TRACK 1  Retribution R/02_nlp_integration.Rmd  →  E3–E7
```

Two handoffs, in both directions:

1. **R → Colab.** `Retribution R/01_main_analysis.Rmd` writes
   `Retribution R/data/cleaned/retribution_scored.csv`. Colab **NB04** consumes it as the
   participant-level survey validators, and Colab **NB01** can optionally use it
   to seed the survey-signal strata of the gold sample.
2. **Colab → R.** The Colab facet outputs flow back into
   `Retribution R/02_nlp_integration.Rmd`, which applies the preregistered §6.7 validation
   gate and runs **E3–E7**. Drop the downloaded CSVs into `NLP/outputs/` (or
   `NLP/colab/`) and re-knit — `02` searches both, first hit wins.

`02_nlp_integration.Rmd` is written to **knit before any Colab output exists**:
every NLP input is behind a `file.exists()` guard, and a missing stream prints an
explicit *"awaiting Colab outputs"* notice naming the file it needs, instead of
failing.

## Which data file to use

Qualtrics exports two flavors. **Use `Data/FullData_Values.csv` for all numeric
analysis — it is the complete collection, 1,015 raw responses.** In the Values
file every 7-point item is a clean 1–7 integer. `Data/` also holds an interim
partial export (`Pilot_300_*`); always read the full file.

The **Labels** file is a **codebook only**: for 7-point scales it prints anchor
text for 1/4/7 but bare numbers for 2/3/5/6, so it cannot be averaged. The two
flavors are identical for open-ends, sliders, sentences, and `Vignette`. Keep
Labels open next to the data to read the categorical decodes (gender, race,
PoliticalID, Shark y/n) and to sanity-check coding direction; the instrument is
identical throughout, so the decodes in `Pilot_300_Labels.csv` apply to every
response.

The export carries **three header rows** (names, question text, ImportId JSON):
read row 1 as the column names, then skip 3.

## Run order

**Track 1 (R Markdown, in `Analysis/Retribution R/` — open the `.Rproj` first):**

1. `01_main_analysis.Rmd` — cleaning, exclusions, vignette coalescing, reverse
   coding, within-vignette standardization of the sentence, composites with α and
   ω, the retributivist measures, then H1–H21. **Writes the scored dataset both
   tracks share.**
2. `03_supplementary_analyses.Rmd` — E1, E2, the correlate factor structure, the
   first→second sentence change, political/prosecution-leaning moderators,
   agreement among the four retributivist definitions, and the response-quality
   report (prereg §6.6). Reads the scored CSV from step 1.
3. `02_nlp_integration.Rmd` — **run last**, once the Colab outputs are on disk.
   The §6.7 gate, then E3–E7 with Benjamini–Hochberg applied within that one
   exploratory family.

**Track 2 (Colab, in `Analysis/NLP/colab/`):**

1. `01_preprocessing_and_facets` — **two-pass notebook.** Pass A: Section 0.5
   builds `openends_long.csv` from the raw Values export inside the notebook,
   then the 9-facet word list runs and the model-independent stratified gold
   sample is drawn → send the template to human coders and **stop**. Pass B (after
   coders return): IRR, consensus `gold_codes.csv`, the frozen SEED/TEST split,
   and the seeds NB02/NB03 consume.
2. `02_llm_ensemble_scoring` — the production scorer: ≥3 pinned models from ≥3
   developers (≥1 open-weight), temperature 0, 9 multi-label facets per
   `item_type` + the holistic principled-vs-vengeful call.
3. `03_embeddings_and_similarity` — secondary convergence only, never a gate:
   per-facet mean cosine similarity to human-coded reference sets, leave-one-out,
   ≥3 embedding models, cross-model rank stability.
4. `04_convergence_validation_export` — merges every stream with the gold codes
   and the survey validators, applies the triple gate (A human-match ∧ B
   inter-model ICC ∧ C discriminant survey validity), and writes the OSF bundle.

Notebooks are chained by `files.upload()` / `files.download()` — no
`drive.mount` — and pin their package versions in the Section 0 cell.

## Data-cleaning decisions baked in (qsf vs prereg)

- **Sentence columns are vignette-split** (`Sentence1_V1/_V2/_V3`,
  `Sentence_OpenEnd1_V1/_V2/_V3`, etc.). They are coalesced into
  `Sentence1` / `Sentence2` / `Sentence_OpenEnd1` / `Sentence_OpenEnd2` via the
  embedded `Vignette` field — in `01_main_analysis.Rmd` for the survey side and in **Colab NB01
  Section 0.5** for the open-ends. Slider exports carry a trailing `_1`.
- **Ranking explanation** exports as `Priorit_Explain` (the prereg calls it
  **Q333**). Both tracks log the mapping where they read it.
- **Ranking → retributivist:** `Prioritization_1` is the rank given to "criminals
  deserve to be punished"; `== 1` ⇒ ranked first ⇒ retributivist (371 of 948,
  39.1%).
- **Attention checks:** AttnCheck1 pass = value **9**; AttnCheck2 pass = **4**
  ("15").
- **CRT** sliders scored 0–3; correct answers **5, 5, 47** (CRT_3's unit is
  mislabeled "Minutes" in the instrument).
- **Retribution_6/7** are already recoded 1–7 in the Values export — do not
  reverse them again.
- **severity_1** is reverse-keyed **only** inside the just-deserts
  proportionality component, never for the standalone H4/H5 severity items.
- **Exclusions** (`Finished == 1`, `Progress == 100`, `AttnCheck1 == 9`,
  `AttnCheck2 == 4`) leave **N = 948 of 1,015** (1015 → 965 finished → 958 after
  AttnCheck1 → 948 after AttnCheck2). Vignette assignment is near-perfectly
  balanced (315 / 317 / 316) and there are no duplicate Prolific IDs.
- **`punitiveness` is the eight self-report items.** `punitiveness_full` adds
  `Sentence1_z` and is **never** used where the sentence sits on both sides of a
  model — this is the E7 circularity rule.
- The three open-ends are scored **separately and never concatenated** (prereg
  §5.15): `ranking` (Q333, backward-looking), `backward` (Q1, sentence
  justification), `forward` (Q2, what the sentence should accomplish). Word count
  is a covariate throughout (§6.7).

## Preregistration

**`Docs/Preregistration/Final/` is authoritative** — "Retribution Study -
Preregistration, DGK, June 29" (`.docx` and `.pdf`, finalized 29 June 2026). The
other files in `Docs/Preregistration/` are superseded drafts; do not analyze
against them. The OSF registration is complete: the embargoed registration was
approved 5 July 2026 and the embargo completed 11 July 2026.

Track 1 follows that document as written. E3 through E7 form one exploratory
family and Benjamini–Hochberg is applied within it (prereg §2.4, §6.7); nothing
in the language analysis is confirmatory.

Every place the NLP design does something the prereg does not say, or says
differently, is listed in the **deviation register**: `NLP/MEASUREMENT_DESIGN.md`
**§0, "Deviations from the final preregistration"** — a row-per-deviation table
giving the prereg text, what we do instead, why, and whether it needs an **OSF
addendum**. The rows flagged `YES` go up as a single dated addendum to the
completed registration, posted **before** any ensemble scoring or human coding
begins.

## Open team decisions

Track 2 does not run end to end until the team settles these. The notebooks stop
at the point where a decision is still missing:

- **`NLP/colab/KNOWN_GAPS.md`** — the notebook punch-list: what has to be set
  before a first run (model IDs, the gold-coding pass) and the rough edges to
  tighten.
- **`NLP/MEASUREMENT_DESIGN.md` §11, "Open decisions for the team"** — the 14
  substantive decisions: the model roster and pinned versions, who drafts the
  OSF addendum and when it posts, gold-standard size and coders, the human-match
  threshold, the strictness of the gate union, the status of censure /
  moral-balance / proportionality, the discriminant-foil rule, E4 elicitation,
  facet score representation, negation depth, the analysis unit for E4–E6,
  multiple-comparison scope, and OSF release scope.

## What is on disk

```
Analysis/
├── README.md                                    ← this file
├── Retribution Study -- NLP Methods Review, v1.md
├── Retribution R/                               TRACK 1  (RStudio project)
│   ├── Retribution R.Rproj             ← open this
│   ├── 01_main_analysis.Rmd            + .html
│   ├── 02_nlp_integration.Rmd          + .html
│   ├── 03_supplementary_analyses.Rmd   + .html
│   ├── data/cleaned/   retribution_scored.csv/.rds, reliability_table.csv,
│   │                   retribution_nlp_features.csv,
│   │                   retribution_supplementary_vars.csv
│   ├── output/tables/  per-hypothesis CSVs
│   ├── output/figures/ PNGs
│   ├── figure/         knitr scratch
│   └── _superseded/    superseded .R scripts + first-tranche output, DO NOT RUN
├── NLP/                                         TRACK 2
│   ├── MEASUREMENT_DESIGN.md    ← the WHY (incl. §0 deviations, §11 open decisions)
│   ├── NOTEBOOK_BLUEPRINT.md    ← the HOW
│   ├── colab/                   ← the four notebooks + KNOWN_GAPS.md
│   ├── outputs/                 ← drop Colab downloads here for 02 to find
│   └── _superseded/             ← superseded local .py prototypes, DO NOT RUN
└── (no `R/` folder — Track 1 lives entirely in `Retribution R/`)
```

> **Status: confirmatory.** Data collection is **complete**. Track 1 runs on the
> full export, **N = 948 after the preregistered exclusions** (1,015 raw), so per
> prereg §4.4 — "no hypotheses are tested before collection ends" — these are the
> real confirmatory results, not a dry run.
>
> The stated target was 960 valid responses (§4.2); the realized N is **948, a
> 1.25% shortfall**. The power consequence is negligible: the smallest detectable
> correlation moves from r ≈ .090 to r ≈ .091 (§4.3).
>
> **Track 2 is pending**, so E3–E7 in `02_nlp_integration.Rmd` are awaiting the
> Colab facet outputs.
