---
name: nemo-speech-asr-finetune
description: Fine-tune a NeMo ASR model on a custom dataset using the NeMo Docker container on any NVIDIA GPU. Handles dataset prep, manifest creation, config generation, and training launch. Validated on DGX Spark (GB10).
allowed-tools: Bash Read Write Edit
argument-hint: [dataset_path] [pretrained_model] [max_epochs]
---

# NeMo ASR Fine-tune

Fine-tunes a NeMo ASR model using the NeMo Docker container on any NVIDIA GPU.

## Defaults
- Model: `stt_en_conformer_ctc_small`
- Dataset: AN4 (letter transcription toy example)
- Precision: `bf16-mixed` (Ampere/Hopper/GB; swap to `16-mixed` on older GPUs)
- Epochs: 10

## Inputs from arguments
- `$ARGUMENTS[0]` — path to dataset root (default: `./data/an4`)
- `$ARGUMENTS[1]` — pretrained model name or path to `.nemo` file (default: `stt_en_conformer_ctc_small`)
- `$ARGUMENTS[2]` — max epochs (default: `10`)

## Valid pretrained models (NeMo 25.04)
English CTC conformer models verified to exist in the NGC registry:
- `stt_en_conformer_ctc_small` (default, ~14M params)
- `stt_en_conformer_ctc_medium` (~30M params)
- `stt_en_conformer_ctc_large` (~120M params)
- `stt_en_conformer_ctc_xlarge`
- `stt_en_conformer_ctc_small_ls` / `_medium_ls` / `_large_ls` (LibriSpeech variants)

Other languages: `stt_fr_`, `stt_de_`, `stt_es_`, `stt_hi_`, `stt_it_` conformer variants available.
To list all: `docker run --rm nvcr.io/nvidia/nemo:25.04 python -c "import nemo.collections.asr as nemo_asr; [print(m.pretrained_model_name) for m in nemo_asr.models.EncDecCTCModelBPE.list_available_models()]"`

## Workflow

### Step 1 — Verify environment
```bash
nvidia-smi
docker images | grep nvcr.io/nvidia/nemo
```
Confirm an NVIDIA GPU is visible and the NeMo 25.04 image is present.

### Step 2 — Download dataset (if not already present)
If `$ARGUMENTS[0]` is not set or the data directory is empty, run:
```bash
./scripts/download_an4.sh
```

### Step 3 — Process dataset into NeMo manifests
Run inside the NeMo container:
```bash
docker run --rm --gpus all -v $(pwd):/workspace nvcr.io/nvidia/nemo:25.04 \
  bash -c "pip install -q sox librosa && \
           python /workspace/scripts/process_an4_data.py --data_root /workspace/data/an4"
```
This produces `train_manifest.json` and `test_manifest.json` under `data/an4/an4/`.

### Step 4 — Launch fine-tuning
```bash
./scripts/run_an4_finetune.sh
```
Checkpoints land in `outputs/AN4_ASR_Finetune_DGX_Spark/`.

### Step 5 — Monitor training
In a second terminal, watch TensorBoard:
```bash
docker run --rm --gpus all --network host \
  -v $(pwd)/outputs:/outputs nvcr.io/nvidia/nemo:25.04 \
  tensorboard --logdir /outputs --host 0.0.0.0 --port 6006
```
Then open `http://localhost:6006` in the browser.

## Troubleshooting
- **`sox` not found**: the container install step in `run_an4_finetune.sh` handles this.
- **OOM**: reduce `batch_size` in `configs/an4_finetune.yaml`. On DGX Spark (unified memory) check `free -h`; on discrete GPUs check `nvidia-smi`.
- **Slow first epoch**: model download from NGC on first run; subsequent runs use the cache.
- **`val_wer` not improving**: verify manifests have correct paths with `head data/an4/an4/train_manifest.json`.
- **`Model X was not found`**: the model name does not exist in the NeMo 25.04 registry. Use `list_available_models()` command above to find valid names.
