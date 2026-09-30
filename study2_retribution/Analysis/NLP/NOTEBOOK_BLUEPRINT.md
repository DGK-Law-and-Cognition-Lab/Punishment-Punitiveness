# Retribution Study — Colab Notebook Blueprint

Four Google Colab notebooks that mirror the Dark Side `01–04` structure but are **re-tooled** from the prosocial/dark binary to the 9-label facet scheme. This blueprint is the build spec: for each notebook it gives purpose, inputs/outputs (Drive/Colab paths), and an **ordered cell list** with the key code sketched (not full implementations). Read it alongside `MEASUREMENT_DESIGN.md`, which owns the *why*; this file owns the *how*.

**Companion file:** `MEASUREMENT_DESIGN.md` (same directory). Section references below — "design §7" and the like — point into it.

## Colab conventions kept across all four notebooks (from the Dark Side pipeline)

- **No `drive.mount`.** Notebooks are chained by `files.upload()` / `files.download()` and cached `.npy`. Each notebook uploads the previous notebook's CSV output.
- **`pip install` with PINNED versions** in a Section 0 cell (e.g. `anthropic==x.y.z`, `sentence-transformers==3.0.1`, `voyageai`, `krippendorff`, `pingouin`). Pin every dated **model** string too.
- **API keys via `userdata.get(...)`** in a `try/except` that raises on empty: `Punishment_ClaudeAPI`, `Punishment_VoyageAPI`, plus a key for the open-weight endpoint (e.g. `Punishment_OpenWeightAPI`).
- **Cached embeddings** saved as `{model}_response_embeddings.npy` and reloaded with a `.shape[0] == len(df)` assert (BGE required; mpnet/voyage optional).
- **Prefilled-JSON parsing + `FAILURE_LOG`** — reuse `JSON_SYSTEM_PROMPT`, prefilled `{'role':'assistant','content':'{'}`, `parse_json_safe(prefill='{')`, `normalize_label()`, module-level `FAILURE_LOG` (cap 5), `claude_call(max_retries=4)` backoff, `ThreadPoolExecutor(max_workers=8)` `future→index`, `text[:1500]` truncation, ≥3-word `df_valid` filter. Parse failures are stored as explicit `None` rows, never dropped.
- **The sentence circularity rule** — E7 uses `punitiveness` (8 items), never `punitiveness_full` (which embeds `Sentence1_z`).
- **Within-vignette z** — `Sentence1_z` is consumed pre-computed from Track 1's `01_main_analysis.Rmd`; notebooks never recompute it. Facet scores are standardized within `vignette × item_type` wherever vignettes are pooled.
- **Everything binary from Dark Side is dropped:** `prosocial_cats`/`dark_cats`, `just_prosocial`/`_dark`/`_minus_dark`, `PROSOCIAL_LABELS`/`DARK_LABELS`, `add_similarity_columns` b3a/b3b/b3c, `prototype_sensitivity_master.csv` (45-cell), `% closer to dark`, the 5-way convergence heatmap, the façade/sincerity/cultural-default tests. The prosocial-minus-dark roll-up survives only as a single secondary descriptive footnote.

## Drive/repo layout (paths are relative to the NLP directory)

```
Retribution/Analysis/NLP/
  MEASUREMENT_DESIGN.md             # companion — the why
  NOTEBOOK_BLUEPRINT.md             # this file — the how
  colab/
    01_preprocessing_and_facets.ipynb
    02_llm_ensemble_scoring.ipynb
    03_embeddings_and_similarity.ipynb
    04_convergence_validation_export.ipynb
  _superseded/                      # retired local prototypes, provenance only — never run
    01_extract_openends.py          #   its extraction lives in NB01
    02_facet_dictionary.py          #   its FACETS regexes are ported verbatim into NB01 §2
  outputs/
    openends_long.csv               # 900 rows, first tranche
    facet_dictionary_scores.csv     # NB01 out
    gold_sample_template.csv        # NB01 out  → coders
    gold_codes.csv                  # NB01 out  (after coders return)
    gold_split_assignment.csv       # NB01 out  (frozen SEED/TEST, design §8)
    ensemble_facet_scores.csv       # NB02 out  (long: response × item × facet)
    ensemble_raw_per_model.jsonl    # NB02 out  (verbatim, → OSF)
    ensemble_agreement.csv          # NB02 out  (ICC / Krippendorff / human-match)
    embedding_facet_similarity.csv  # NB03 out
    {bge,mpnet,voyage}_response_embeddings.npy  # NB03 cache
    retribution_nlp_features.csv    # NB04 out  (merged, participant- and item-level)
    gate_table.csv                  # NB04 out  (A/B/C per facet)
    e3_e7_results.csv               # NB04 out
```
`Retribution R/data/cleaned/retribution_scored.csv` (Track 1's scored survey file, carrying the 24 validator columns) is uploaded into NB04.

---

# Notebook 01 — `01_preprocessing_and_facets`

**Purpose.** Ingest the tidy long open-ends, run the refined 9-facet word list (the ported dictionary), draw and write the **model-independent** stratified gold-standard sample, ingest coder returns and compute IRR, freeze the SEED/TEST split, and emit the seeds (embedding reference pools + lexicon-expansion candidates) that NB02/NB03 consume. Mirrors Dark Side NB01 but replaces VADER/Empath/prosocial-dark with the facet dictionary + gold prep.

**Inputs:** `outputs/openends_long.csv` (uploaded); optionally `Retribution R/data/cleaned/retribution_scored.csv` for the survey-signal strata; the returned coder spreadsheet(s) on the second run.
**Outputs:** `facet_dictionary_scores.csv`, `gold_sample_template.csv`, `gold_codes.csv`, `gold_split_assignment.csv`, `embedding_seed_pools.json`, `lexicon_expansion_candidates.csv`.

### Ordered cells

1. **[markdown]** Title + purpose + the "no drive.mount / chained by upload" note. State that NB01 runs in **two passes**: pass A writes the coder template and stops; pass B (after coders return) ingests codes, computes IRR, freezes the split, emits seeds.
2. **[code] Install** — `!pip install -q krippendorff pingouin statsmodels` (pinned). No transformers/GPU here.
3. **[code] Imports** — `pandas, numpy, re, json, itertools`; `from google.colab import files`; `import krippendorff`.
4. **[markdown]** Section 1 — Load and validate the long file.
5. **[code] Upload + load** — `files.upload()`; `df = pd.read_csv(fn)`. **Assert the shape:** `assert set(df.item_type.unique()) == {'ranking','backward','forward'}`. **Log the Q333 resolution:** print that `item_type=='ranking'` came from the `Priorit_Explain` column so the Q333/`Priorit_Explain` mismatch cannot silently drop the item. Print non-blank counts and word medians per item (first tranche: 298/300/299, 32/19/13).
6. **[markdown]** Section 2 — Refined 9-facet word list (ported from `_superseded/02_facet_dictionary.py`).
7. **[code] Facet regex buckets** — paste the 9 disjoint `FACETS` dicts, carrying the `just` / `remove` / `pay for` routing rules of design §6. Sketch:
   ```python
   FACETS = { 'desert':[r"deserv\w*", r"just deserts?", r"pay for (what|it|his|her|their)", ...],
              'proportionality':[...], 'censure':[...], 'moral_balance':[...],
              'revenge':[r"payback", r"make (him|her|them) pay", r"an eye for an eye", ...],
              'suffering':[...], 'deterrence':[...], 'incapacitation':[r"remove\w* from society", ...],
              'rehabilitation':[...] }
   OPPOSING = [('desert','revenge'),('desert','suffering'),('proportionality','revenge'),
               ('moral_balance','revenge'),('moral_balance','suffering'), ...]
   ```
8. **[code] Duplicate/opposing-token assertion** — the independence guard. Sketch:
   ```python
   for a,b in OPPOSING:
       assert set(FACETS[a]).isdisjoint(FACETS[b]), f"shared token: {a}/{b}"
   ```
   Print a one-line note that this is a *double-count guard, not proof of construct independence* — real independence is measured at the response level in NB04 (design §2). **Keep the contestable ambiguous tokens** (`held accountable`, bare `pay for the pain`) **out of the dictionary** rather than fiat-routing them; those are left to the LLM and the human coders.
9. **[code] Negation ZERO-OUT (whitelist, no sign-flip)** — design §6. Build a hand-curated whitelist of verified negation+cue trigrams, seeded later from the gold set; on pass A ship an empty/placeholder list. Sketch:
   ```python
   NEG_ZERO = ["don't want him to suffer","doesn't deserve mercy", ...]  # inspected case-by-case
   def negation_zeroed(text, raw_hits):
       # zero ONLY exact whitelisted spans; never sign-flip; "deserve no mercy" is pro-desert -> untouched
       ...
   ```
   Emit **both** `<facet>` (raw) and `<facet>_negzeroed` columns; the neg-zeroed column is flagged "never feeds a gate."
10. **[code] Score + write** — per row: raw counts, `<facet>_per100`, `n_words`. Emit `facet_dictionary_scores.csv`. Print mean hits per facet by item_type and the **realized sparsity** (first tranche: revenge ~0.7%, suffering ~2.5%, proportionality ~1.0%, censure ~1.4%, moral_balance ~0.7% nonzero) — this table feeds the **≥5% coverage rule** downstream (design §6).
11. **[markdown]** Section 3 — Stratified gold-standard sample (**model-independent**, design §8).
12. **[code] Build the strata** — join survey signal if available. **Three model-free strata:**
    ```python
    # (a) stratified RANDOM slice across deserved tertiles x item_type  -> nonzero inclusion for blind-spot cases
    # (b) SURVEY-signal disagreement stratum: high revenge/suffering survey scorers
    #     whose dictionary facet is 0 (survey-model disagreement = where a shared blind spot lives)
    # (c) reserve ~50 responses for an OPEN human read-through (no filter at all)
    strata = pd.concat([random_stratified(df, by=['deserved_tertile','item_type'], n=...),
                        survey_disagreement(df, survey), open_readthrough_reserve(df, n=50)])
    assert 'ensemble' not in stratum_definition and 'embedding' not in stratum_definition
    ```
    Print a note: **no stratum is defined solely by ensemble or embedding output** (design §8).
13. **[code] Write coder template** — `gold_sample_template.csv` with `response_id, item_type, text` and blank facet columns + holistic column. **Two coder materials variants (design §8):** one **bottom-up** (construct definitions only, no pinned token decisions, no LLM anchors) and one full-codebook; at least one coder does the bottom-up pass first. **STOP here on pass A** (markdown cell instructs the analyst to send to coders).
14. **[markdown]** Section 4 — (pass B) Ingest coder returns + IRR.
15. **[code] Load coder files + IRR** — align coders; per-facet Cohen's kappa / **Gwet's AC1** (imbalanced revenge/suffering) + analytic SE; Krippendorff's alpha on holistic. Sketch:
    ```python
    ac1, ac1_se = gwet_ac1(coderA[f], coderB[f])   # AC1 for sparse facets
    alpha = krippendorff.alpha(holistic_matrix, level_of_measurement='nominal')
    ```
    Flag facets that are **hard for humans too** (likely censure/moral_balance) — those are descriptive-only regardless of any survey scale. Record the **bottom-up vs. codebook boundary divergences as findings** (design §8), not coder error.
16. **[code] Adjudicate + freeze split** — adjudicate to consensus `gold_codes.csv`. Partition gold responses ONCE into SEED/TEST and write `gold_split_assignment.csv` (design §8). Print: "SEED feeds embedding refs, lexicon expansion, held-out rubric anchors; TEST feeds every gate/convergence number." The split is frozen before NB02 scoring.
17. **[code] Emit seeds (from SEED half only)** — `embedding_seed_pools.json` (8–15 high-facet / low-opposing-facet exemplars per facet, mixed-motive cases placed in both relevant sets); `lexicon_expansion_candidates.csv` (facet-positive-but-dictionary-missed spans); update the `NEG_ZERO` whitelist from real gold negations. **All drawn from SEED only.**
18. **[markdown]** Next step → NB02; list downloads.
19. **[code] Downloads** — `files.download(...)` for every output above.

---

# Notebook 02 — `02_llm_ensemble_scoring`

**Purpose.** The **primary scorer**. Score every response per `item_type` on the 9 multi-label facets + holistic across ≥3 pinned models from ≥3 developers (≥1 open-weight), temperature 0. Compute ensemble-vs-human agreement on the gold TEST set **first** and block any facet failing the human-match bar; then compute the ensemble mean / holistic majority / cross-model ICC / Krippendorff for passing facets; save all raw per-model JSON; run the shared-error diagnostic; export a stratified human-coding template refresh if needed. Mirrors Dark Side NB02 but replaces DeBERTa+Claude prosocial/dark with the multi-model facet ensemble.

**Inputs:** `facet_dictionary_scores.csv`, `openends_long.csv`, `gold_codes.csv`, `gold_split_assignment.csv` (uploaded).
**Outputs:** `ensemble_facet_scores.csv` (long: `response_id × item_type × facet`), `ensemble_raw_per_model.jsonl` (verbatim → OSF), `ensemble_agreement.csv`, `human_match_by_stratum.csv`.

### Ordered cells

1. **[markdown]** Title + purpose + the human-match-before-scoring guard.
2. **[code] Install (pinned)** — `!pip install -q anthropic==... openai==... google-generativeai==... krippendorff pingouin`. For the open-weight model: either `!pip install -q together` (hosted) or transformers+GPU (Colab GPU). **Pin every dated model string.**
3. **[code] Imports** — `json, time, re`; `ThreadPoolExecutor, as_completed`; `from google.colab import userdata, files`; `import krippendorff, pingouin as pg`.
4. **[code] API keys** — `Punishment_ClaudeAPI`, second-developer key, `Punishment_OpenWeightAPI`, each in `try/except` raising on empty (reuse the Dark Side cell verbatim). Define the pinned model registry:
   ```python
   MODELS = {'claude':'claude-<stronger-tier>-<date>',            # above Haiku
             'gpt':'gpt-<snapshot>',   # or gemini-<snapshot>
             'open':'meta-llama/Llama-3.x-70B-Instruct'}          # or Qwen2.5-72B, pinned revision
   ```
5. **[markdown]** Section 1 — Load inputs (open-ends + dictionary + gold + split).
6. **[code] Upload + load + merge** — load long open-ends; attach dictionary scores; load `gold_codes.csv` and `gold_split_assignment.csv`. `df_valid = df[df.n_words >= 3]`.
7. **[markdown]** Section 2 — The 9-facet rubric (identical across models).
8. **[code] Rubric + schema** — paste `JSON_SYSTEM_PROMPT` (the annotator system prompt from design §4). Define the strict JSON schema with the 9 facets + `holistic` + optional `evidence`. The scored prompt carries boundary **definitions** and negation/stance **teaching cases** but **holds out numeric anchor targets** (or draws anchors from the SEED half), and the `evidence` span is **optional** — "facet present but not attributable to a single span" is allowed (design §4). Sketch:
   ```python
   FACET_RUBRIC = """Score each of nine facets 0.0-1.0 INDEPENDENTLY... distinguish DESERT/PROPORTIONALITY/
   CENSURE/MORAL-BALANCE... handle negation and stance... do not infer a facet from the crime."""
   SCHEMA = '{"desert":0.0,...,"rehabilitation":0.0,"holistic":"principled|vengeful|both|neither","evidence":{}}'
   ```
9. **[code] Per-model call helpers** — reuse `parse_json_safe`, `normalize_label`, `FAILURE_LOG`, backoff `claude_call`; write thin adapters `gpt_call` / `open_call` with the **same** prompt, temp 0, seed where supported, `text[:1500]`. Each returns the 9-facet dict or `None`. `None` becomes an explicit row (never dropped).
10. **[code] E4-critical SEPARATE-CALL helpers (design §4)** — define single-facet prompts for `desert` and `revenge` scored in **independent** calls, so the joint read cannot manufacture their correlation:
    ```python
    def score_facet_solo(text, item_type, facet, model):  # one facet, one call, no other-facet context
        ...
    ```
    Also prepare a **no-mixed-anchor** variant of the rubric to quantify anchor sensitivity.
11. **[markdown]** Section 3 — The ensemble loop (full corpus, all models).
12. **[code] Ensemble loop with saved raw output** — for each model, `ThreadPoolExecutor(max_workers=8)` over `df_valid`, `future→index`. **Save the verbatim JSON of every call** to `ensemble_raw_per_model.jsonl` (one line per `response_id × item_type × model`), including parse failures. Sketch:
    ```python
    for m in MODELS:
        results=[None]*len(df_valid)
        with ThreadPoolExecutor(max_workers=8) as ex:
            futs={ex.submit(call[m], t, it): i for i,(t,it) in enumerate(zip(texts,items))}
            for fut in tqdm(as_completed(futs), total=len(futs)):
                i=futs[fut]; results[i]=fut.result()
                raw_jsonl.write(json.dumps({'rid':..., 'item':..., 'model':m, 'raw':results[i]})+"\n")
        store[m]=results
    ```
    Then run the **separate-call** desert/revenge pass and the no-mixed-anchor pass, storing both.
13. **[markdown]** Section 4 — Human-match FIRST (gate clause A), computed on gold **TEST** only.
14. **[code] Ensemble-vs-human agreement (BEFORE trusting the mean)** — restrict to `gold_split=='TEST'`. Per facet: ICC (graded) or Gwet's AC1 (categorical) of ensemble vs. human consensus, **with bootstrap 95% CI**. Gate on the **CI lower bound ≥ .60** AND `n_pos ≥ 30` in TEST, and report CI width beside every number (design §7). Report human-match **separately for anchor-adjacent (clean) vs. boundary/mixed strata** → `human_match_by_stratum.csv` (design §4). Mark any facet failing this as `human_match=FAIL` and **block it from gate-backed use**.
    ```python
    for f in FACETS:
        est, lo, hi = bootstrap_icc_or_ac1(ens_mean[test][f], human[test][f])
        n_pos = (human[test][f] > 0).sum()
        clauseA[f] = (lo >= .60) and (n_pos >= 30)
    ```
15. **[code] Shared-error diagnostic (design §4)** — on gold TEST, per facet: **signed bias** (ensemble mean − human consensus) and **cross-model error correlation** (residual `model−human` correlated across models = shared blind spot). Require roughly zero-mean, cross-model-independent errors before trusting the mean; else flag `biased` and cap that facet's gate-backed use. **Report the open-weight model's standalone human-match separately** — do not let majority vote bury its disagreement.
16. **[markdown]** Section 5 — Aggregate (passing facets) + reliability.
17. **[code] Ensemble mean + holistic majority + reliability** — for facets passing clause A: facet score = **mean across models**; holistic = **majority**. Cross-model **ICC(2,k) and ICC(2,1)** (pingouin), **Krippendorff alpha** on holistic. Where the dictionary clears the ≥5% coverage floor (design §6), also report **ensemble↔dictionary** agreement. Write `ensemble_agreement.csv`.
18. **[code] Export** — `ensemble_facet_scores.csv` in **long** form (`response_id, item_type, facet, ensemble_mean, holistic, human_match_pass, per_model_scores...`), plus the separate-call desert/revenge columns tagged for E4. Download raw JSONL + agreement + scores.
19. **[markdown]** Section 6 — Optional: refresh the stratified human-coding template. If human-match flagged coverage gaps (e.g. a facet with `n_pos < 30`), **export a top-up stratified template** oversampling that facet's positive region via **survey signal**, not ensemble output (design §8).
20. **[code] Downloads** — all outputs.

---

# Notebook 03 — `03_embeddings_and_similarity`

**Purpose.** Secondary/convergence only. Per-facet reference-passage similarity with ≥3 pinned embedding models, seeded from **real gold SEED-half exemplars**, per-item cosine, leave-one-out, with per-facet absolute-shift and cross-model rank-stability reporting. Never a headline; never gates a facet. Mirrors Dark Side NB03 but drops the 5 synthetic prototype sets and the prosocial-minus-dark gap.

**Inputs:** `ensemble_facet_scores.csv`, `openends_long.csv`, `embedding_seed_pools.json`, `gold_split_assignment.csv` (uploaded).
**Outputs:** `embedding_facet_similarity.csv`, `{bge,mpnet,voyage}_response_embeddings.npy` (cache).

### Ordered cells

1. **[markdown]** Title + "secondary/convergence, never a gate, never a headline."
2. **[code] Install (pinned)** — `!pip install -q sentence-transformers==3.0.1 voyageai`.
3. **[code] Imports + API key** — `torch, numpy`; `Punishment_VoyageAPI` via `userdata` (raise on empty).
4. **[markdown]** Section 1 — Load inputs + the reference pools.
5. **[code] Upload + load** — long open-ends; `embedding_seed_pools.json` (SEED-half exemplars, 8–15 per facet); `gold_split_assignment.csv`. `texts = df.text.fillna('').tolist()`.
6. **[markdown]** Section 2 — Shared helpers (identical across all 3 models).
7. **[code] Helpers** — reuse `normalize_rows`, `normalize_vec`. Replace prototype-centroid logic with **per-facet reference-set mean cosine**, computed **per item_type**, with **leave-one-out**:
   ```python
   def facet_similarity(resp_emb, ref_embs_by_facet, resp_ids, seed_ids_by_facet):
       # mean cosine of each response to a facet's reference SET;
       # exclude a response from any set containing it (LOO)
       ...
   ```
8. **[markdown]** Section 3 — mpnet (v2 baseline).
9. **[code] mpnet encode + cache** — `mpnet.encode(texts, batch_size=32, normalize_embeddings=True, convert_to_numpy=True)`; `np.save('mpnet_response_embeddings.npy', emb)`; on rerun reload with `assert emb.shape[0]==len(df)`. Embed the reference pools; compute per-facet per-item similarity.
10. **[markdown]** Section 4 — BGE (**required/primary**).
11. **[code] BGE encode + cache + similarity** — same pattern; `bge_response_embeddings.npy`. BGE is the required model (assert its cache; mpnet/voyage optional).
12. **[markdown]** Section 5 — Voyage.
13. **[code] Voyage batched + retries** — reuse `voyage_embed_batch(batch_size=64)` 3-attempt retry + blank guard; cache `voyage_response_embeddings.npy`; per-facet per-item similarity.
14. **[markdown]** Section 6 — Model-sensitivity reporting (per facet, not a prosocial-dark gap).
15. **[code] Sensitivity table** — per facet report (a) **absolute** mean similarity per model (expected to shift) and (b) **cross-model rank-order correlation** of response ordering (expected stable). Only rank-stable facets enter convergence. Sketch:
    ```python
    for f in FACETS:
        abs_shift = {m: sim[m][f].mean() for m in MODELS}
        rank_stab = {(m1,m2): spearman(sim[m1][f], sim[m2][f]) for m1,m2 in pairs}
    ```
    **Coverage:** for the sparse facets, the embedding leg counts only where it yields nonzero-variance, human-validated signal (design §5). **Frozen split:** any embedding-vs-human number is computed on **TEST only**; refs came from **SEED only**.
16. **[code] Export** — `embedding_facet_similarity.csv` (`response_id, item_type, facet, {model}_sim`). Download. **Dropped:** `add_similarity_columns b3a/b3b/b3c`, the retribution-as-knob variants, `prototype_sensitivity_master.csv`, `% closer to dark`.
17. **[markdown]** Next step → NB04.

---

# Notebook 04 — `04_convergence_validation_export`

**Purpose.** Merge all facet streams + gold human codes + survey validators; compute the full agreement matrix **including the human-anchored leg**; apply the **triple gate (A human-match ∧ B ICC ∧ C discriminant survey gate)**; run the re-aimed within-person E3–E7 tests; export the analysis file, the gate table, and the OSF bundle. Mirrors Dark Side NB04 but drops the 5-way convergence heatmap and all façade tests.

**Inputs:** `ensemble_facet_scores.csv`, `embedding_facet_similarity.csv`, `facet_dictionary_scores.csv`, `gold_codes.csv`, `gold_split_assignment.csv`, `Retribution R/data/cleaned/retribution_scored.csv` (uploaded).
**Outputs:** `retribution_nlp_features.csv`, `gate_table.csv`, `e3_e7_results.csv`, plus the OSF bundle (prompts, versions, word lists, embedding ref sets, raw per-model JSON, gold codes + IRR).

### Ordered cells

1. **[markdown]** Title + purpose + the gate/anti-circularity summary.
2. **[code] Install (pinned)** — `!pip install -q pingouin krippendorff statsmodels`.
3. **[code] Imports** — `pandas, numpy, pingouin as pg, statsmodels.formula.api as smf`; bootstrap util.
4. **[markdown]** Section 1 — Merge everything.
5. **[code] Load + join** — upload the five feature files + `retribution_scored.csv`. Join facet streams on `response_id × item_type`; join survey validators on `ResponseId == response_id` (participant-level). Print the realized counts and check them against what NB01 logged (first tranche: survey N = 295, corpus 897 non-blank rows).
6. **[markdown]** Section 2 — Agreement matrix (incl. human leg).
7. **[code] Full agreement matrix** — per facet per item_type: cross-model **ICC(2,k)/ICC(2,1)**, **Krippendorff** on holistic, **ensemble↔dictionary** (only where the dictionary clears the ≥5% coverage floor, design §6), and the **headline ensemble↔human accuracy** on gold TEST with bootstrap CIs. Emit a tidy `agreement_matrix.csv`.
8. **[markdown]** Section 3 — The §6.7 triple gate.
9. **[code] Gate A (human-match)** — from NB02: CI **lower bound ≥ .60** AND `n_pos ≥ 30` in TEST; report by clean/boundary stratum (design §4, §7).
10. **[code] Gate B (reliability)** — ensemble ICC(2,k) ≥ .60; also carry the **shared-error flag** from NB02 (a `biased` facet is capped even if ICC passes).
11. **[code] Gate C (discriminant survey validity)** — build the full **facet × survey-scale correlation matrix** (ensemble facet score at the routed item — Q1 for desert/revenge/suffering — vs. participant survey scale, **word-count partialled, within-vignette z**). Require the **diagonal to beat the STRONGEST off-diagonal rival by Δr ≥ .15 with non-overlapping bootstrap CIs**, not a hand-picked orthogonal foil. **DESERT must beat `revenge` and `suffering`; REVENGE must beat `deserved` with a partial-correlation unique-component test.** Where two survey scales are collinear (.6+), **demote** the facet — the survey cannot arbitrate that boundary (design §7).
    ```python
    for f in GATE_FACETS:
        r_own = partial_corr(facet[f], survey[map[f]], covar=['n_words'])
        rivals = {s: partial_corr(facet[f], survey[s], covar=['n_words']) for s in SCALES if s!=map[f]}
        top_rival = max(rivals, key=lambda s: rivals[s])
        clauseC[f] = (r_own >= .30) and (r_own - rivals[top_rival] >= .15) and ci_nonoverlap(...)
    ```
12. **[code] Gate table + facet routing** — write `gate_table.csv` (`facet, clauseA, clauseB, clauseC, status`). **Flag as descriptive-only:** CENSURE and MORAL-BALANCE (**no admissible survey anchor — proxies struck, design §7**) and PROPORTIONALITY (**~1% base rate, design §7**; if the realized Q1/Q333 nonzero rate is < 10%, report the desert-vs-proportionality text result as a **descriptive null-by-absence**). Gate-eligible facets: DESERT, REVENGE, SUFFERING. Every facet's status is a validation standing, not a confirmatory label — all E3–E7 output is exploratory.
13. **[markdown]** Section 4 — E3–E7 (within-person, re-aimed).
14. **[code] E3** — ranking-defined retributivists (`Prioritization_1 == 1`) vs. others on gate-passing facet intensities, **Q333 and Q1 SEPARATELY, never pooled**; the two backward items treated as a within-study replication. Effect sizes + bootstrap CIs; word count covariate. **Exploratory; gate-backed; inside the one E3–E7 BH-FDR family.**
15. **[code] E4 — within-person desert × revenge co-occurrence** — computed from the **separate-call** ensemble facet scores (design §4); report the **joint-call vs. split-call** correlation difference as the halo diagnostic (collapse under split = artifact). **Both non-model corroborators are reported (design §6):** the preregistered **word-list** co-occurrence with its bootstrap CI, joint-firing count, and realized prevalence — reported as uninformative-by-base-rate, with counts, if revenge falls below the ≥5% floor — **and** the **human gold set**, computed by coders blind to the ensemble at an effect size and direction fixed in advance. Benchmark against survey r(deserved,revenge)=.61 as a **convergent reference only, not a criterion** (design §7). The holistic "both" rate is descriptive only, barred from the E4 evidence family (design §9). **Exploratory; gate-backed, resting on the human anchor; inside the one E3–E7 BH-FDR family.**
16. **[code] E5 / text H6 — desert vs. proportionality** — the survey side (r=.053) is the standing H6 evidence. The **text-side** co-occurrence estimate uses **only the separately-called LLM ensemble + human gold codes**; the **dictionary and embedding streams are EXCLUDED** (enforced token/anchor disjointness mechanically depresses joint firing, design §10). **Verify on gold that coders CAN and DO co-assign desert=1 & proportionality=1** (report the base rate); if they essentially never do, report as **descriptive null-by-absence**, not a gate-backed orthogonality test. **Exploratory; descriptive-only facet; inside the one E3–E7 BH-FDR family wherever it yields a test statistic.**
17. **[code] E6 — backward-minus-forward** — within-person `delta_f = facet(Q1 or Q333) − facet(Q2)`; retributive facets predicted to peak backward, consequentialist forward. **Exploratory; descriptive; INSIDE the one E3–E7 BH-FDR family.**
18. **[code] E7 — sentence model on punitiveness_8item** — predict `Sentence1_z` from gate-passing facets **beyond `punitiveness` (8 self-report items), NEVER `punitiveness_full`** (r=.44 vs .85). Also test revenge/suffering language → `Shark_3` and the sentence. Within-vignette z consumed from Track 1; word count covariate. **Exploratory; gate-backed; inside the one E3–E7 BH-FDR family.**
    ```python
    base = smf.ols('Sentence1_z ~ punitiveness', d).fit()               # 8-item, NOT _full
    full = smf.ols('Sentence1_z ~ punitiveness + desert + revenge + suffering + n_words', d).fit()
    delta_r2 = full.rsquared - base.rsquared
    ```
19. **[code] FDR + effect sizes** — **one Benjamini-Hochberg family across the whole of E3–E7** (prereg §2.4, §6.7): E5, E6, and any test produced by a descriptive-only facet are inside the count, and no language test is labelled confirmatory. Report effect sizes + bootstrap 95% CIs throughout. Decide nesting per the open decision (participant aggregates vs. mixed models vs. clustered SEs) — implement whichever the team ratifies (design §11.12).
20. **[markdown]** Section 5 — Export + OSF bundle.
21. **[code] Export** — `retribution_nlp_features.csv` (participant- and item-level), `gate_table.csv`, `e3_e7_results.csv`. Assemble the **OSF bundle**: all prompts, pinned model versions, word lists, embedding reference sets, **raw per-model JSON**, gold codes + IRR + the **frozen SEED/TEST split assignment**, and the gate table. Verbatim participant text must be cleared for de-identification before release. **Dropped:** `map_broad` 5-way convergence, the façade heatmap, individual-façade/sincerity/cultural-default tests, `cross_method_convergence_5way.csv`.
22. **[code] Downloads** — every output + the footnote-only prosocial-minus-dark descriptive (single secondary line).
23. **[markdown]** Done — pointer back to `MEASUREMENT_DESIGN.md` §11 open decisions.
