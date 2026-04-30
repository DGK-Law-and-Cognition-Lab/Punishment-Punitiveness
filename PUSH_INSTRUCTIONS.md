# How to Push This to GitHub

This document walks through getting the updated repo onto your existing GitHub remote at https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness.

The new contents are a substantial rewrite — most files are replaced, three are removed, and several are added. Three approaches, depending on how much Git history you want to preserve.

---

## Option A: Force-replace (cleanest, loses prior commit history)

Use this if the repo has only your commits and you don't need history of the old version.

```bash
# 1. Clone the existing repo (fresh)
git clone https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness.git
cd Punishment-Punitiveness

# 2. Wipe everything except .git
find . -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +

# 3. Copy in the new contents (from the unzipped Punishment-Punitiveness-updated.zip)
cp -r ../Punishment-Punitiveness-updated/Punishment-Punitiveness/. .

# 4. Stage, commit, push
git add -A
git commit -m "Major restructure: new title, expanded NLP pipeline, two-PDF manuscript

- Title changed: 'Is Criminal Punishment Prosocial?' -> 'The Dark Side of Punishment'
- Author order: Simon, Melnikoff, Kamper (with UChicago Law affiliation added)
- NLP pipeline expanded to three embedding models (BGE, voyage-3, MPNet)
- Five prototype variants for embedding multiverse (45 combinations)
- Claude Haiku 4.5 added as forced-choice classifier (100% top-1 accuracy)
- BART-MNLI retired (77.5% accuracy)
- Manuscript split into two compilable PDFs (main + supplementary)
- Findings reframed: cultural-default-with-selective-suppression
- Five Rmd files consolidated into three; one Python notebook split into three
- Updated README, CITATION, index.html, codebooks, docs/"
git push origin main --force
```

---

## Option B: Branch-and-merge (preserves history, gives you a review step)

Use this if you want a merge commit on `main` that documents the restructure as one logical change.

```bash
# 1. Clone and create a branch
git clone https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness.git
cd Punishment-Punitiveness
git checkout -b restructure-2026

# 2. Wipe everything except .git
find . -mindepth 1 -maxdepth 1 -not -name '.git' -exec rm -rf {} +

# 3. Copy in the new contents
cp -r ../Punishment-Punitiveness-updated/Punishment-Punitiveness/. .

# 4. Commit and push the branch
git add -A
git commit -m "Major restructure (see commit body for details)"
git push -u origin restructure-2026

# 5. Open a Pull Request on GitHub:
#    https://github.com/DGK-Law-and-Cognition-Lab/Punishment-Punitiveness/pull/new/restructure-2026
#    Review the diff in the GitHub UI, then merge to main.
```

---

## Option C: Granular commits (slowest, best Git log)

Use this if you want clean, atomic commits for each logical change. Most laborious but produces the best Git history. Roughly:

```bash
# (After cloning and creating a branch)

# Commit 1: Update top-level docs
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/README.md .
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/CITATION.cff .
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/.gitignore .
git add -A && git commit -m "Update title, authors, citation, add .gitignore"

# Commit 2: Replace the manuscript directory
rm -rf manuscript
cp -r ../Punishment-Punitiveness-updated/Punishment-Punitiveness/manuscript .
git add -A && git commit -m "Restructure manuscript: two-PDF setup with xr-hyper cross-references"

# Commit 3: Replace analysis code
rm -rf analysis
cp -r ../Punishment-Punitiveness-updated/Punishment-Punitiveness/analysis .
git add -A && git commit -m "New analysis pipeline: 3 R Rmds + 3 Python notebooks"

# Commit 4: Update data files and codebooks
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/data/processed/*.csv data/processed/
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/data/codebook/*.md data/codebook/
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/data/README.md data/
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/data/raw/README.md data/raw/
git add -A && git commit -m "Update NLP features CSV (411 cols) + codebooks"

# Commit 5: Replace docs
rm -rf docs
cp -r ../Punishment-Punitiveness-updated/Punishment-Punitiveness/docs .
git add -A && git commit -m "Update analysis plan, methodology, NLP summary"

# Commit 6: Update index.html
cp ../Punishment-Punitiveness-updated/Punishment-Punitiveness/index.html .
git add -A && git commit -m "Rebuild GitHub Pages site for new findings"

# Push
git push -u origin restructure-2026
```

---

## After Pushing: Set Up GitHub Pages

If GitHub Pages isn't already configured:

1. Go to repo **Settings → Pages**
2. Under "Build and deployment," set:
   - **Source**: Deploy from a branch
   - **Branch**: `main` (or `gh-pages` if you prefer to keep it separate)
   - **Folder**: `/` (root)
3. Save. The site will be live at `https://dgk-law-and-cognition-lab.github.io/Punishment-Punitiveness/` within a couple of minutes.

If it's already configured, no action needed — pushing to `main` will auto-rebuild.

---

## Before You Push: Final Sanity Checks

Run these from the new repo root before committing:

```bash
# 1. Confirm no API keys leaked
grep -r "sk-ant-\|pa-[a-z0-9]" . --include="*.py" --include="*.ipynb" --include="*.R" --include="*.Rmd"
# Should return nothing.

# 2. Confirm the data file has the new column count
head -1 data/processed/punishment_212_nlp_features.csv | tr ',' '\n' | wc -l
# Should print: 411

# 3. Confirm all section files referenced by main.tex exist
grep "input{" manuscript/main.tex | sed 's/.*input{\(.*\)}.*/\1/'
ls manuscript/sections/ manuscript/tables/

# 4. Confirm xr-hyper is set up in main.tex
grep -c "xr-hyper\|externaldocument" manuscript/main.tex
# Should print 2 (one for each line)

# 5. Confirm citation block in README.md is current
grep "simon2026darkside\|kamper2026" README.md
# Should print only "simon2026darkside" — kamper2026 = old citation key
```

---

## After Pushing: Generate and Push the HTML Reports

The GitHub Pages site links to `analysis/r/01_main_analysis.html` and five other HTML files that don't exist yet. See `HOW_TO_REGENERATE_REPORTS.md` for the regeneration steps. Then:

```bash
git add analysis/r/*.html analysis/python/*.html
git commit -m "Add knitted HTML reports"
git push origin main
```

After this push, every link on the site works.

---

## Troubleshooting

- **"Permission denied" on push**: You're either not authenticated or don't have push rights. Set up SSH key (`ssh-keygen` + add to GitHub) or use a personal access token.
- **Pages site shows 404**: Confirm Settings → Pages is set up and pointing at the right branch. Wait 2–3 minutes after the first deploy.
- **Pages site shows the old content**: GitHub Pages aggressively caches. Try a hard refresh (Cmd+Shift+R) or visit with a `?v=2` query param to bust the cache.
- **CSS broken on Pages**: Check that the `index.html` file is at the repo root (not in a subdirectory). The current build has it at the root, which is correct.
