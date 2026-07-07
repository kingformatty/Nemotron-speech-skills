# Sub-Skill Registry

The orchestrator delegates execution to these sub-skills. Each entry gives the role (from the ASR customization
architecture), the skill to invoke, what to hand it, what it returns, and the fallback when it is a **placeholder**
(not yet available). Invoke a sub-skill with the Skill tool by its `name`; if unavailable, tell the user, give the
interim guidance, and continue.

## Research / Training

- **Invoke:** `nemo-speech-asr-finetune` (NeMo ASR fine-tuning: container setup, checkpoint selection, Lhotse data,
  tokenizer, training, checkpoint averaging, and the eval stage).
- **Hand it:** the chosen path, checkpoint/family, style-audited train/val/test manifests, constraints
  (streaming/offline, precision, GPU budget), and any blend/replay requirement.
- **Returns:** trained/averaged `.nemo` checkpoint(s) and in-training `val_wer`.
- **Notes:** owns all exact NeMo flags/config paths and model-family recipes (CTC/RNNT/TDT/hybrid/AED, plain vs prompted
  cache-aware streaming). Also holds the "recipes / best-practice knowledge base." (Do **not** route ASR training to
  `nemotron-customize` — that skill is for Nemotron **LLM** customization, not speech.)

## SDG / Data Designer

- **Invoke:** `data-designer` (or the NeMo-platform variant `nemo-data-designer-plugin`) to build **synthetic text
  datasets** — domain term lists, target-style transcripts, and prompts. It generates text/tabular data, **not audio**.
- **For synthetic audio:** turn that text into speech with a TTS model. `nemotron-speech` can run TTS inference
  (e.g. Magpie) to synthesize audio, but it is a NIM deploy/run skill, so this is a heavier step than text generation —
  scope whether synthetic audio is actually needed before committing.
- **Hand it:** the domain/language, target transcript style, required volume, and formats of any vendor/customer data.
- **Returns:** synthetic transcripts/text (data-designer) and, if used, synthesized audio (via TTS).
- **Placeholder — `asr-data-profiling`:** noise profiling, in-domain noise harvest, vendor-data impact analysis, and
  assembling `(audio, transcript)` manifests are not yet a dedicated skill. Interim: profile audio (sample rate, SNR,
  duration/tps distributions), harvest realistic in-domain noise, score vendor samples with the current model, align
  format, and keep synthetic sources separately weighted. Flag missing real target-domain data explicitly.

## Evaluation

- **Invoke:** `nemo-speech-asr-finetune` and use its **evaluation stage** — standalone WER/CER via
  `speech_to_text_eval.py` with the default scoring contract (lowercased, punctuation removed) and cache-aware streaming
  eval. It is the ASR-WER-capable sub-skill; evaluation lives inside it rather than as a separate skill.
- **Hand it:** the checkpoint(s), the domain eval set, and a general guardrail set.
- **Returns:** normalized domain WER and per-variant comparisons; the orchestrator computes the general-set forgetting
  delta and the error-category breakdown from these to pick the next lever.
- **Note:** `nemo-evaluator-plugin` is a NeMo Platform eval CLI for served endpoints/LLM-style metrics, **not** ASR WER —
  do not route ASR accuracy evaluation there.

## Deployment / Optimization

- **Invoke:** `nemotron-speech` (Riva NIM: export `nemo2riva`, `riva-build`/`riva-deploy`, pipeline config, and serving).
  This is also where **runtime/decoding customizations** (word boosting, custom vocab/pronunciation, n-gram LM at decode,
  ITN, VAD, diarization) and any NIM build-time optimization live.
- **Hand it:** the evaluated `.nemo`, the target hardware/latency, and any runtime customization list (boost words, LM,
  vocab) recommended in path selection.
- **Returns:** a deployed/served NIM and runtime configuration.
- **Note:** ASR export/serving optimization is part of the NIM build in `nemotron-speech`; do **not** route it to
  `nemotron-customize` (Nemotron LLM customization/ModelOpt), which does not apply to speech models.

## Ownership / provenance (for maintainers)

The architecture assigns owners per box — Research/Training (Research), SDG/Data (Data Designer + Eng), Evaluation
(Research/Eng), Deployment/Optimization (Skills/NIM). Keep this registry updated as placeholder skills are published so
routing points at the real `name` rather than interim guidance. A working analog of this orchestration pattern is the
Clinical ASR Flywheel (`digital-health-clinical-asr-*`: setup → build → eval → finetune), read from those skills'
frontmatter.
