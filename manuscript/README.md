# Manuscript

LaTeX source for *The Dark Side of Punishment*, formatted with the **apa7** document class for submission to the **Journal of Personality and Social Psychology**.

## Two PDFs from One Project

The manuscript is structured as **two compilable documents** within the same source tree:

- `main.tex` → `main.pdf` (the manuscript proper: title, abstract, intro, two studies, general discussion, references)
- `supplementary.tex` → `supplementary.pdf` (a separate document: verbatim survey items, all sensitivity analyses, NLP pipeline details, validation tables)

This matches JPSP's submission format — the supplement is uploaded as a separate PDF, not appended to the main manuscript.

The two PDFs share `references.bib` and cross-reference each other via the `xr-hyper` LaTeX package. See `OVERLEAF_SETUP.md` for step-by-step instructions on how to compile both from one Overleaf project.

## Files

```
manuscript/
├── main.tex                      # Wrapper for main.pdf
├── supplementary.tex             # Wrapper for supplementary.pdf
├── references.bib                # Shared bibliography
├── OVERLEAF_SETUP.md             # How to compile both PDFs in Overleaf
├── sections/
│   ├── introduction.tex          # The Punitive Mindset, Self-Report, Present Research
│   ├── study1.tex                # Study 1 Method + Results + Discussion
│   ├── study2.tex                # Study 2 Method + Results + Discussion
│   ├── general_discussion.tex    # Cross-study integration, limitations, conclusion
│   └── supplementary_body.tex    # Pulled in by supplementary.tex
├── tables/                       # 16 .tex files: tables and figure wrappers
└── figures/                      # PNGs referenced by the figure wrappers
```

## Build (Local)

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

# (Optional final pass for cross-document refs)
pdflatex main
```

For Overleaf usage, see `OVERLEAF_SETUP.md`.
