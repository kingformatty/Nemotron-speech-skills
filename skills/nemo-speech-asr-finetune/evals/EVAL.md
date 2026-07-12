# NeMo ASR Fine-tune Eval Guidance

Use `evals/evals.json` to verify argument passthrough, environment checks, and training launch for the execution skill `nemo-speech-asr-finetune`.

## What to grade

- The skill should activate when the orchestrator (`nemotron-asr-finetune`) delegates fine-tuning, or when a user directly requests NeMo ASR training.
- Central behaviors:
  1. **Environment check first** — verify GPU (`nvidia-smi`) and Docker image before any training command.
  2. **Argument passthrough** — dataset path, pretrained model, and max epochs must all flow through to the Hydra config.
  3. **Correct model names** — validate the pretrained model exists in the NeMo registry; surface `list_available_models()` on failure.
  4. **Clean launch** — Docker run with `--gpus all`, correct volume mounts, correct config overrides.
- Grade down: launching training without environment check; ignoring argument overrides (using hard-coded values); no guidance on invalid model names.
