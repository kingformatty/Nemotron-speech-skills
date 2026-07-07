# Path Selection — Cheapest Sufficient Rung

Stage 3 of the workflow. Pick the **lowest-cost path that can meet the target**, escalate only when quality falls short,
and delegate execution to the sub-skills. Always diagnose the failure mode first and measure a baseline (Evaluation
sub-skill) so each step is justified.

Ordering and per-model support follow the NVIDIA Speech NIM (Riva) ASR customization guide:
<https://docs.nvidia.com/nim/speech/latest/asr/customization/customization.html>. Verify parameters and support there.

## The Ladder (cheapest → most expensive)

| Rung | Fixes | Needs | Cost | Runs where → sub-skill |
|---|---|---|---|---|
| **Word boosting** | Known words/names/jargon/commands | A word list | Minimal, no training | Runtime → `nemotron-speech` |
| **Custom vocabulary / pronunciation** | OOV words, consistent mispronunciations | Vocab/lexicon file | Low, deploy-time | `riva-build` → `nemotron-speech` |
| **N-gram (KenLM) LM** | Domain phrasing / word sequences | Domain **text** | Moderate, text-only | Build (Research/Training + SDG) → deploy `nemotron-speech` |
| **Fine-tune** | Real acoustic gaps (accents, noise, channel) | 100+ h transcribed (10 h floor if mixed) + GPU | High | Research/Training (`nemo-speech-asr-finetune`) |
| **Train from scratch / cross-language** | A new language/dialect, no checkpoint | Thousands of h (16+ h for transfer) | Very high | Research/Training (last resort) |

Rungs compose: a fine-tuned model still uses boosting and an LM at serving time.

## Diagnose First

- **A short, known set of specific words wrong** (names, SKUs, commands, acronyms) → **word boosting**; if truly OOV or
  mispronounced → **custom vocabulary / pronunciation**.
- **Wrong word sequences / phrasing**, with domain text available → **n-gram LM**.
- **Model mis-hears audio** (accent, noise, channel) with a real acoustic gap and enough transcribed audio →
  **fine-tune**.
- **New language/dialect, no suitable checkpoint** → train from scratch / cross-language transfer (rare).
- **Formatting only** (punctuation, casing, numbers) → runtime automatic-punctuation / ITN flags, not accuracy work.

## Rung Notes (docs-grounded)

- **Word boosting:** Parakeet CTC/RNNT/TDT and Nemotron ASR Streaming. Scores ~20–100 (CTC), 0.5–2.0 (RNNT/TDT);
  per-stream ~500 words (RNNT/TDT) / 5,000+ (CTC); global (deploy) 5,000+. Cannot fix acoustics. Tutorial:
  <https://github.com/nvidia-riva/tutorials/blob/stable/asr-wordboosting.ipynb>.
- **Custom vocab / pronunciation / speech hints:** deploy-time `riva-build`, primarily Parakeet CTC.
- **N-gram (KenLM) LM:** Parakeet CTC (`--decoding_language_model_binary`) and RNNT (`--nemo_decoder.language_model_file`).
  Text-only; can't add acoustic capability. Tutorials: CTC
  <https://github.com/nvidia-riva/tutorials/blob/stable/asr-python-advanced-nemo-ngram-training-and-finetuning.ipynb>,
  RNNT (NGPU-LM) <https://github.com/nvidia-riva/tutorials/blob/main/asr-train-and-deploy-NGPU-LM-for-parakeet-rnnt.ipynb>.
- **Fine-tune:** for genuine acoustic gaps. NIM guide: 100+ h recommended; ~10 h floor **only if mixed** with a
  larger dataset to avoid catastrophic forgetting. Lossless audio, ≥16 kHz, noise augmentation. Supported: Parakeet
  CTC/RNNT/TDT and Nemotron ASR Streaming.
- **Train from scratch / cross-language:** 5,000+ h from scratch; ~16+ h with cross-language transfer. Prefer
  fine-tuning a multilingual checkpoint first.

## Escalation Rule

Start at the lowest matching rung, measure, and escalate only if the target is missed. It is fine to run a cheap-rung
experiment (boosting / LM) immediately while presenting the full fine-tuning plan and its cost — see
[`planning-answers.md`](planning-answers.md). Change one lever per iteration.
