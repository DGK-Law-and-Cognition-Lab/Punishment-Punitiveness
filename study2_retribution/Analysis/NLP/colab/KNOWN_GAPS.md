# Colab notebooks — what to set before running, and what to tighten

Four notebooks, run in order. NB01 is executable today; NB02–NB04 wait on two
things: the model roster and the human gold codes. Everything below is either a
prerequisite for a first run, a choice to ratify, or a rough edge worth tightening.

## What has been exercised

- **NB01 runs end to end on `FullData_Values.csv`** (1,015 responses), pass-A path,
  and stops where it should for the coders. Two consecutive runs produce
  byte-identical `openends_long.csv`, `facet_dictionary_scores.csv` and
  `gold_sample_template.csv`, so the draw is reproducible from `RANDOM_SEED`.
  Realized facet prevalence on the full corpus: desert 20.3%, rehabilitation 22.3%,
  deterrence 15.3%, incapacitation 13.8%, suffering 1.8%, proportionality 1.2%,
  censure 0.9%, moral_balance 0.5%, revenge 0.5%. Five facets sit under the 5%
  coverage floor and the notebook flags each one as unavailable as an independent
  convergence leg.
- **All four notebooks are `nbformat`-4 valid and every code cell parses.**
- **NB02 → NB04 file contracts line up on inspection**: the split files join on
  `(response_id, item_type)` in every notebook, `ensemble_agreement.csv` carries the
  eight columns NB04 asserts, and the E4 solo scores travel as `desert_solo` /
  `revenge_solo` rows that NB04 pivots into `ens_desert_solo` / `ens_revenge_solo`.
- **Not yet exercised against data:** NB02, NB03 and NB04. NB02 needs API keys and a
  pinned roster; NB03 needs the seed pools NB01 emits in pass B; NB04 needs
  `gold_codes.csv` and `gold_split_assignment.csv`. Their contracts have been checked
  by reading the writer against the reader, not by running the chain.

## Set before the first run

- **Upload `retribution_scored.csv` when NB01 Section 3 asks for it.** The prompt
  calls it optional; in practice it is not. It carries the analytic sample
  (N = 948 after prereg §6.2), and it is what restricts the gold pool to
  participants who actually enter the analysis. Skip it and the pool spans all
  1,015 responses — on the current data that puts 8 rows in front of coders that no
  analysis will ever use. With it, the pool is 2,837 rows across all 948 participants.
- **Pin the `MODELS` IDs in NB02.** The registry ships placeholders
  (`claude-<STRONGER-TIER>-<YYYYMMDD>`, `gpt-<SNAPSHOT>`,
  `meta-llama/Llama-3.x-70B-Instruct-<PINNED-REV>`); every call 400s until they are
  replaced with dated snapshots. Team decision #1 in `MEASUREMENT_DESIGN.md` §11.
  The roster must satisfy prereg §6.7: ≥3 models from ≥3 developers, ≥1 open-weight.
- **Pin the Voyage snapshot in NB03.** `VOYAGE_MODEL` is `voyage-3-large`; design §5
  names `voyage-4-large` (or the current Voyage). Same decision. BGE is the required
  leg and its `.npy` cache is asserted on reload; mpnet and Voyage are optional.
- **Run the gold-coding pass.** NB01 is two-pass. Pass A builds `openends_long.csv`,
  scores the word list, draws the stratified sample, writes `gold_sample_template.csv`
  and `codebook_bottom_up.txt`, and stops. Coders return one CSV each, then pass B
  computes IRR, adjudicates `gold_codes.csv`, and freezes the SEED/TEST split. NB02
  gate A, NB03's seed pools and NB04's convergence step all consume those files.
- **Confirm the gold-code column schema.** NB02's `HUMAN_COL(f)` expects bare facet
  names. If the returned coder export suffixes them (`desert_gold`), gate A records
  every facet as FAIL rather than raising. Add a hard assert on the column set once
  the real template comes back, so a schema mismatch fails loudly.

## Choices to ratify

- **Gold sample = 308 rows, one row per participant**, drawn scarcest-stratum-first
  (survey-disagreement 60 → random-stratified 198 → open read-through 50) against a
  shared `used` set. Against the ~250–300 target in design §8. Trimming means
  changing `STRATUM_A_CELL` or `STRATUM_C_N`.
- **The survey-disagreement stratum ranks rather than samples.** Among rows the
  dictionary scores 0, it takes the highest survey revenge/suffering scorers
  (drawn range 6.75–7.00 and 6.50–7.00 against pool medians 4.25 / 3.50), interleaving
  the two facets. A flat random draw over the ~1,100 qualifying rows would not sit in
  the disagreement region at all.
- **Coder ties are left unresolved.** `TIE_RULE = 'unresolved'` writes NaN and every
  facet carries a `<facet>_tie` column; `'present'` and `'absent'` are implemented
  beside it. Ties are printed per facet with an instruction to adjudicate.
- **`ensemble_facet_scores.csv` carries 11 rows per response**, not 9: the two extra
  are `facet='desert_solo'` and `facet='revenge_solo'`, which is the only route by
  which E4's halo-free estimate reaches NB04.
- **Word-list columns are `dict_<facet>` in the merged export.** Six of the nine facet
  names are also survey scale names, so the dictionary counts are prefixed and NB04
  asserts that every name in `SURVEY_SCALES` resolves to a survey column. Any
  previously produced `gate_table.csv` predates this and should be regenerated.
- **E4 stops rather than warns** when the solo columns are absent, so the study's
  central language test cannot silently drop out of the BH-FDR family.
- **`biased_flag`** is written as a real boolean and parsed by `_flag_to_bool`, which
  also accepts `0/1` and the words `biased`/`ok` and raises on anything else.

## Rough edges

### NB01 — `01_preprocessing_and_facets`
- **Gwet AC1 analytic SE** uses a constant per-unit chance term, so it collapses
  toward a binomial-style SE rather than the true linearized Gwet variance. The point
  estimate is unaffected and the SE feeds no gate, but it should be corrected before
  publication.
- **Adjudication indexing** assumes a unique `(response_id, item_type)` row per coder.
  Add a `drop_duplicates` or uniqueness assert at coder load.
- `random_stratified()` re-uses `RANDOM_SEED` for every cell — reproducible, but the
  cells are not independently seeded.
- The sparsity print still names the first-tranche expectations (revenge ~0.7%,
  suffering ~2.5%) beside the realized full-corpus values; harmless, but the two sets
  of numbers sit side by side.

### NB02 — `02_llm_ensemble_scoring`
- **`ensemble_raw_per_model.jsonl` holds the coerced 9-facet dict, not the verbatim
  model text.** Prereg §6.7 wants "all raw output saved so the scoring can be
  repeated", so the adapters should also stash each call's raw `content`; parse
  failures past `FAILURE_LOG`'s cap of 5 are otherwise unrecoverable. Archival only —
  it changes no score.
- **`evidence` spans are requested and coerced but never exported.**
- **The clean-vs-boundary human-match numbers go to `human_match_by_stratum.csv`**,
  not into `ensemble_agreement.csv`, so NB04 treats `human_match_clean` /
  `human_match_boundary` as optional and leaves that column blank. Either emit them
  as columns or accept the blank.

### NB03 — `03_embeddings_and_similarity`
- **`rank_stable` threshold = 0.50** (minimum pairwise Spearman across encoders) is an
  implementer choice, not a value the design fixes; Dark Side rank stability ran ≈.71.
  It is disclosed in the export so a reader can re-threshold.
