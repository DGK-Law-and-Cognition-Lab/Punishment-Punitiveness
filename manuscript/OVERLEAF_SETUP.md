# Splitting the Supplement into a Separate PDF (within the Same Overleaf Project)

This document explains how the manuscript is now structured to compile two separate PDFs from one project — `main.pdf` and `supplementary.pdf` — and how to set that up in Overleaf.

---

## What Changed

Before this restructuring, the supplement was an `\input{}` at the end of `main.tex`, producing one giant PDF with the supplement appended. Now:

- **`main.tex`** — compiles to `main.pdf` (the manuscript Dan/Davids submit).
- **`supplementary.tex`** — compiles to `supplementary.pdf` (a separate document that references shared labels and bibliography).
- **`supplementary_body.tex`** — the supplement's actual content (sections, tables, prose). Pulled in by `supplementary.tex` via `\input{}`.
- **`references.bib`** — shared by both, no duplication.

The two PDFs cross-reference each other where needed via the `xr-hyper` package (see "Cross-references between documents" below).

---

## Project Structure on Overleaf

Inside the Overleaf project, files should live in this layout:

```
project_root/
├── main.tex                          ← compiles to main.pdf
├── supplementary.tex                 ← compiles to supplementary.pdf
├── references.bib                    ← shared by both
├── sections/
│   ├── introduction.tex
│   ├── study1.tex
│   ├── study2.tex
│   ├── general_discussion.tex
│   └── supplementary_body.tex        ← pulled in by supplementary.tex
├── tables/
│   ├── H1_correlations.tex
│   ├── steiger.tex
│   ├── reliability.tex
│   ├── descriptives.tex
│   ├── demographic_moderation.tex
│   ├── political_moderation.tex
│   ├── nlp_method_summary.tex
│   ├── nlp_facade.tex
│   ├── nlp_multiverse.tex
│   ├── nlp_theme_correlations.tex
│   ├── nlp_regression.tex
│   ├── fig_heatmap_cluster.tex
│   ├── fig_heatmap_construct.tex
│   ├── fig_sentence_anchor.tex
│   ├── fig_bootstrap.tex
│   └── fig_facade_heatmap.tex
└── figures/
    ├── sentence_histogram_overall.png
    ├── sentence_histogram_by_vignette.png
    ├── heatmap_cluster_level.png
    ├── heatmap_construct_level.png
    └── facade_correlations_heatmap.png
```

---

## Switching Between Documents in Overleaf

Overleaf compiles whichever file is set as the "Main document." To switch between compiling `main.pdf` and `supplementary.pdf`:

1. Click the **Menu** button (top-left).
2. Under **Settings → Main document**, choose either:
   - `main.tex` to build `main.pdf`
   - `supplementary.tex` to build `supplementary.pdf`
3. Click **Recompile**.

You'll need to do this once per document. Overleaf remembers the most recent setting.

For day-to-day editing, set whichever file you're actively working on as the main document — that gives you live preview while you work.

---

## Build Order (First-Time Setup)

Because the two documents cross-reference each other, you need to compile each one twice on the first build (LaTeX needs `.aux` files from one to resolve refs in the other).

**Recommended first-build sequence:**

1. Set `supplementary.tex` as Main document → Recompile → Recompile (twice).
2. Set `main.tex` as Main document → Recompile → Recompile (twice).
3. Set `supplementary.tex` as Main document → Recompile (once more, to pick up any back-references).

After this, every subsequent edit just needs one or two recompiles of the document you're editing.

---

## Cross-References Between Documents

The main text already references two sections in the supplement:

- `\ref{sec:supp_materials}` — the verbatim survey items section
- `\ref{sec:supp_vignettes}` — the full sentencing vignettes

Both labels are defined in `supplementary_body.tex`. The `main.tex` preamble now contains:

```latex
\usepackage{xr-hyper}
\externaldocument{supplementary}
```

This tells LaTeX to read `supplementary.aux` so `\ref{sec:supp_materials}` in the main text resolves to the actual section number (e.g., "S1" or "1") shown in the compiled supplementary PDF.

**If you add a new cross-reference from main → supplement,** just use `\ref{}` with the supplementary label — no changes needed.

**If you ever want refs going the other direction (supplement → main),** add a parallel `\externaldocument{main}` to the supplementary preamble.

---

## What Submission Looks Like

For JPSP submission, you'll upload **two separate PDFs**:

1. `main.pdf` — the manuscript (~30–40 pages with all main-text tables and figures at the end).
2. `supplementary.pdf` — the supplementary materials (~25–30 pages of survey items, sensitivity analyses, NLP pipeline details).

This matches JPSP's standard submission format — they want the supplement as a separate file, not appended to the main manuscript.

---

## Bibliography

Both PDFs share `references.bib`. Each document independently runs BibTeX to produce its own bibliography section, listing only the citations it actually uses. References that appear in both documents will appear in both bibliographies — that's fine and expected.

If you want to suppress the bibliography in the supplement (e.g., because every cite there is already in the main bibliography), comment out `\bibliography{references}` in `supplementary.tex`. The `\citep{}` calls will still resolve their text (e.g., "Smith, 2020"), but no References section will be appended to the supplement.

---

## Quick Sanity-Check Commands

If you're working locally rather than in Overleaf, the commands are:

```bash
# Build main
pdflatex main
bibtex main
pdflatex main
pdflatex main

# Build supplementary
pdflatex supplementary
bibtex supplementary
pdflatex supplementary
pdflatex supplementary

# (Optional) one more pass on main to pick up final supp labels
pdflatex main
```
