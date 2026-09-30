# Study 2: Retribution

This folder holds Study 2 of the paper "The Dark Side of Punishment" by Dan Simon and David G. Kamper: its data, analysis code, survey, preregistration, and the paper and Supplementary Materials. Study 2 is a correlational survey of 948 U.S. adults, recruited through Prolific's representative sample (with quotas for age, sex, ethnicity, and political affiliation) and surveyed in Qualtrics between July 2 and July 23, 2026. It repeats the main tests of Study 1, examines whether the two components of retribution as just deserts (desert theory and the proportionality principle) hang together, and compares the participants who ranked retribution first among four goals of punishment (the retributivists) with the other participants; the paper reports that the retributivists were more punitive and scored higher on nearly every other measure compared.

__Contents__:

- [Preregistration](#preregistration)
- [Folder structure](#folder-structure)
- [How to reproduce the analyses](#how-to-reproduce-the-analyses)
- [Data and de-identification](#data-and-de-identification)
- [What is not included](#what-is-not-included)

## Preregistration

Study 2 was preregistered on the Open Science Framework ([osf.io/u97xs](https://osf.io/u97xs)). The registered document is in `Docs/Preregistration/`.

## Folder structure

```
study2_retribution/
├── README.md
├── Analysis/
│   ├── README.md                      the analysts' overview of the two tracks (see note below)
│   ├── Retribution R/                 R Markdown analyses (an RStudio project)
│   │   ├── Retribution R.Rproj
│   │   ├── .gitignore
│   │   ├── 01_main_analysis.Rmd             + .html
│   │   ├── 02_nlp_integration.Rmd           + .html
│   │   ├── 03_supplementary_analyses.Rmd    + .html
│   │   ├── 04_two_study_figures.Rmd         + .html
│   │   ├── 05_study2_talk_figures.Rmd       + .html
│   │   ├── 06_princeton_talk_figures.Rmd    + .html
│   │   ├── data/cleaned/              scored data written by 01, 02 and 03
│   │   └── output/
│   │       ├── tables/                CSV tables
│   │       └── figures/               PNG figures, and the subfolders two_study/,
│   │                                  study2_talk/ and princeton_talk/ (PNG and PDF)
│   └── NLP/                           language analysis of the open-ended answers
│       ├── MEASUREMENT_DESIGN.md
│       ├── NOTEBOOK_BLUEPRINT.md
│       ├── colab/                     Colab notebooks 00 to 12 and 99, README.md, KNOWN_GAPS.md
│       └── outputs/                   the files the notebooks have written so far, downloaded from Colab
├── Data/
│   ├── FullData_Values.csv            Qualtrics export of all 1,015 responses (numeric codes)
│   ├── Pilot_300_Values.csv           interim export of the first 300 responses (numeric codes)
│   └── Pilot_300_Labels.csv           the same 300 responses with answer labels
├── Experiment/
│   └── Retribution_Study.qsf          the Qualtrics survey
└── Docs/
    ├── Preregistration/
    │   ├── Retribution Study - Preregistration,FINAL, June 29.pdf
    │   └── Final/                     the same registration: its .docx source, and a .pdf
    │                                  marked "Completed and finalized: June 29, 2026"
    └── Writing/
        ├── DARK II - PAPER, CLASS workshop.docx                  the paper
        ├── Retribution -- Supplementary Materials, DRAFT.md      the Supplementary Materials
        ├── Retribution -- Supplementary Materials, DRAFT.docx    the same, as a Word document
        ├── overleaf/retribution-supplement/   LaTeX source of the Supplementary Materials,
        │                                      and a figures/ folder of figure PDFs
        └── figures/
            ├── paper/                 PNGs of the figures 04 draws for the paper and the Supplement
            └── princeton_talk/        PNGs of the talk figures 06 draws
```

The figure files are numbered in the order 04 draws them, not as the paper numbers its figures. The paper's Figures 1 to 11 are, in order, `fig1`, `fig2`, `fig4`, `fig17`, `fig18`, `fig8`, `fig10`, `fig11`, `fig13`, `fig15` and `fig16`. The Supplement's Figures S1 to S6 are `fig5`, `fig6`, `fig7`, `fig9`, `fig12` and `fig14`. The Overleaf `figures/` folder holds the PDF of each of these figures, of which the Supplement uses six. `fig3_study1_sensitivity`, in both folders, and the two `.jpg` files in the Overleaf folder are left over from earlier builds and are in neither document.

`Analysis/README.md` is the analysts' working overview of the two tracks, the R Markdown track and the Colab track. Much of it predates the current notebooks: it names four earlier notebooks and several files and folders that are not included here, gives an earlier knit order, lists decisions that were open at the time, and describes the language analysis as pending. `Analysis/NLP/colab/README.md` describes the current notebooks; the `superseded/` folder it mentions is not included.

## How to reproduce the analyses

### R Markdown

Knit each `.Rmd` in RStudio, after opening `Retribution R.Rproj`, or with `rmarkdown::render()`. Every file reads and writes paths relative to its own folder, so the folder layout must be kept as it is. `01_main_analysis.Rmd`, for example, reads `../../Data/FullData_Values.csv`.

The reports were knit with R 4.5.2. The packages the documents load are:

```r
install.packages(c("rmarkdown", "knitr", "tidyverse", "psych", "GPArotation",
                   "cocor", "lavaan", "effectsize", "corrplot", "scales",
                   "broom", "patchwork", "boot", "car", "lme4"))
```

`02_nlp_integration.Rmd` also uses `irr` and `psychTools` when they are installed.

Knit in this order: 01 → 04 → 05 → 06. Knit 01 first, because every other document reads what it writes; 04, 05 and 06 stop with a message if 01's tables are missing. 02 and 03 also read 01's scored data and can be knit at any point after 01. 03 also reads `Analysis/NLP/outputs/facet_dictionary_scores.csv`, and 02 reads the language-analysis files in `Analysis/NLP/outputs/`.

| Document | What it does | What it writes |
|---|---|---|
| `01_main_analysis.Rmd` | Cleaning, the registered exclusions (1,015 responses to 948), scoring, reliability, and the registered hypotheses | `data/cleaned/retribution_scored.csv` and `.rds`, `data/cleaned/reliability_table.csv`, most of `output/tables/`, and five figures in `output/figures/` |
| `02_nlp_integration.Rmd` | The language analysis of the open-ended answers (E3 to E7), which is not finished (see [Language analysis](#language-analysis-colab)). The included knit has only the word-list results | `data/cleaned/retribution_nlp_features.csv`; the word-list tables `e3_wordlist_preview.csv`, `e4_principled_vengeful.csv`, `e5_desert_proportionality.csv` and `e6_backward_minus_forward.csv`; `gate_table.csv` and `e3_e7_family_fdr.csv`, which hold no results yet; and two figures in `output/figures/` |
| `03_supplementary_analyses.Rmd` | The other exploratory analyses: E1, E2, the factor structure of the correlates, the change between the two sentences, moderators, agreement among the ways of identifying retributivists, and response quality | `data/cleaned/retribution_supplementary_vars.csv`, tables in `output/tables/`, and four figures |
| `04_two_study_figures.Rmd` | The paper's figures for Study 1, for both studies side by side, and for Study 2 | `output/figures/two_study/` (PNG and PDF) and the tables whose names begin with `S1P_` or `two_study_`. It copies each paper figure's PNG to `Docs/Writing/figures/paper/` and its PDF to the figure folders of two Overleaf projects, `retribution-supplement` and `retribution-results` (the Overleaf version of the paper, not included here). It also creates an empty folder, `Docs/Writing/figures/study2/` |
| `05_study2_talk_figures.Rmd` | Figures of Study 2 alone, one per slide, for talks | `output/figures/study2_talk/`, `output/tables/study2_talk_figure_values.csv`, and a copy of each PNG in `Docs/Writing/figures/study2_talk/` (not included here; the same PNGs are in `output/figures/study2_talk/`) |
| `06_princeton_talk_figures.Rmd` | Figures for a talk at Princeton | `output/figures/princeton_talk/`, `output/tables/princeton_talk_figure_values.csv` and `princeton_talk_tests.csv`, and a copy of each PNG in `Docs/Writing/figures/princeton_talk/` |

The knitted reports carry the date of their last knit: 01 on 30 September 2026, 02 on 1 August, 03 on 2 August, 04 on 27 September, 05 on 22 September, and 06 on 29 September. 02, 03 and 05 were knit before later changes to their code or inputs, so a new knit may not reproduce the included reports exactly. 02 and 03 read the scored data of an earlier knit of 01, and 05 was edited after its last knit. When 03 was knit, `facet_dictionary_scores.csv` was not yet in `Analysis/NLP/outputs/`, so the measure that uses it is shown as a placeholder.

`04_two_study_figures.Rmd` also reads Study 1's files. It looks for them in the authors' local folder layout (a folder named `Punishment 2.1`, three levels above the document) and stops unless Study 1's cleaned data file has the md5 checksum of the original file. In this repository Study 1's files are in the top-level `analysis/` and `data/` folders, and they were de-identified, which changes the checksum. 04 also reads Study 1's full Qualtrics export, for the dates of collection; that export has IP address and location columns and is not public. 04 therefore does not knit from this repository, even if its paths are changed; its outputs are included.

### Language analysis (Colab)

The language analysis of the open-ended answers (E3 to E7) is not finished, and it is not reported in the paper or the Supplementary Materials.

The notebooks in `Analysis/NLP/colab/` run in Google Colab, in the order given in `colab/README.md`: 00 to 12. Notebook 99 is an optional human-coding arm outside that chain. Each notebook works in a Colab folder, `/content/retribution_nlp`. Notebook 00 asks for `Data/FullData_Values.csv` by upload, together with `data/cleaned/retribution_scored.csv`, which restricts the corpus to the 948 analyzed participants (without it, the notebook keeps all 1,015 responses and says so). Each later notebook reads the files the earlier ones wrote to that folder, which are listed in `_manifest.json`. Notebook 06 calls language-model APIs. Notebook 08 needs a GPU runtime, and an API key for the optional Voyage encoder. The notebooks read API keys from Colab Secrets; no key is stored in them.

`Analysis/NLP/outputs/` holds the files the notebooks have written so far, downloaded from Colab:

- The full-mode outputs of notebooks 00 to 05, 08 (for three encoders: BGE, MPNet and Voyage) and 09.
- A smoke-mode run of notebook 06 for one model (Claude) on the first 20 participants: 59 scored answers, from 295 calls. The other two models have not been scored.
- `gold_sample_template.csv` and `codebook_bottom_up.txt`, written by an earlier notebook that is not included.

Notebooks 07 and 10 to 12, and the optional notebook 99, have not been run.

`02_nlp_integration.Rmd` reads its inputs from `outputs/`. The included knit of 02 shows only the word-list results: `e3_wordlist_preview.csv`, the word-list rows of the E4, E5 and E6 tables, and `retribution_nlp_features.csv`. For the model scores, the embedding similarities and the human codes, it prints "AWAITING COLAB OUTPUTS". The knit also predates the files now in `outputs/`: it read an earlier word-list file of 900 rows (about 300 participants), which is not included. Its word-list tests therefore rest on 293 to 295 participants, and `retribution_nlp_features.csv` has word-list scores for those 295 participants only. The `facet_dictionary_scores.csv` now in `outputs/` covers all 948.

## Data and de-identification

The files in `Data/` are Qualtrics exports. Each keeps Qualtrics' three header rows (column names, question text, and import IDs) exactly as exported. `FullData_Values.csv` holds all 1,015 responses, and 01 analyzes the 948 that pass the registered exclusions. The two `Pilot_300_` files are an interim export of the first 300 responses, one with numeric codes and one with answer labels.

Identifying information was removed from every data file in this folder: the three exports, and `retribution_scored.csv` and `retribution_scored.rds`, which carry the export's columns.

- The columns `IPAddress`, `LocationLatitude`, `LocationLongitude`, `RecipientLastName`, `RecipientFirstName`, `RecipientEmail` and `ExternalReference` were blanked. The columns themselves are kept, so the code runs unchanged. The last four were already empty in the export.
- Each Prolific ID was replaced by a pseudonym, "P" followed by six digits. One map covers the participants of both studies, so a participant has the same pseudonym in every file of this folder, and a participant who also took part in Study 1 has the same pseudonym in Study 1's files. Spaces and line breaks around an ID were kept.
- Seven entries in the `Prolific_ID` column were not a Prolific ID on their own: IDs with characters added or missing, Prolific e-mail addresses, and other text. Each was replaced by a distinct code, `NONSTANDARD_1` to `NONSTANDARD_7`.
- Because the same ID always became the same code, the duplicate-ID check in 01 gives the same counts as it did on the original export.
- The raw, identifiable exports and the map from Prolific IDs to pseudonyms are kept by the authors and are not public.

`01_main_analysis.Rmd` records the size and md5 checksum of `FullData_Values.csv` in `output/tables/data_provenance.csv`. That table was updated to describe the de-identified file: 936,465 bytes, md5 `03f071fcda5f745c819dae21dc5e92af`. Its row and column counts (1,015 and 146) and the time the file was read are unchanged. The knitted `01_main_analysis.html` still shows the size and checksum of the original export (982,058 bytes, md5 `a2e32ca7fff22ae69c32bc6b92d7e98b`). A new knit of 01 records the checksum of the file it reads.

In `03_supplementary_analyses.html`, three printed local folder paths were shortened to `<local path>`.

## What is not included

- The raw, identifiable data and the pseudonym map.
- Internal working documents (drafts, notes and correspondence) and IRB documents.
- Backups of earlier versions of the R Markdown files and notebooks (files with `BEFORE` in their names), superseded scripts and notebooks, and scratch files (R session files and knitr's scratch figure folder).
