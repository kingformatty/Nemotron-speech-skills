#!/usr/bin/env bash
# Fine-tune a NeMo ASR model on AN4 inside the NeMo Docker container (any NVIDIA GPU).
# Usage: ./scripts/run_an4_finetune.sh [dataset_path] [pretrained_model] [max_epochs]
# Defaults: ./data/an4  stt_en_conformer_ctc_small  10
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
NEMO_IMAGE="nvcr.io/nvidia/nemo:25.04"
NEMO_ROOT="/workspace/nemo_src"

DATASET_PATH="${1:-./data/an4}"
PRETRAINED_MODEL="${2:-stt_en_conformer_ctc_small}"
MAX_EPOCHS="${3:-10}"

# Resolve dataset path to absolute
DATASET_ABS="$(cd "$(dirname "$DATASET_PATH")" && pwd)/$(basename "$DATASET_PATH")"
DATASET_CONTAINER="/workspace/data/$(basename "$DATASET_ABS")"

echo "=== Config ==="
echo "  Dataset:         $DATASET_ABS"
echo "  Pretrained model: $PRETRAINED_MODEL"
echo "  Max epochs:      $MAX_EPOCHS"
echo ""

# Step 1 — prepare data
echo "=== Step 1: Processing dataset ==="
docker run --rm \
    --gpus all \
    --ipc=host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    -v "$REPO_ROOT":/workspace \
    -v "$DATASET_ABS":"$DATASET_CONTAINER" \
    -v "$HOME/tts-hindi-testing/NeMo":"$NEMO_ROOT":ro \
    "$NEMO_IMAGE" \
    bash -c "pip install -q sox librosa && \
             python /workspace/scripts/process_an4_data.py \
               --data_root $DATASET_CONTAINER"

# Step 2 — fine-tune
echo "=== Step 2: Starting fine-tuning ==="
docker run --rm \
    --gpus all \
    --ipc=host \
    --ulimit memlock=-1 \
    --ulimit stack=67108864 \
    -v "$REPO_ROOT":/workspace \
    -v "$DATASET_ABS":"$DATASET_CONTAINER" \
    -v "$HOME/tts-hindi-testing/NeMo":"$NEMO_ROOT":ro \
    "$NEMO_IMAGE" \
    bash -c "cd $NEMO_ROOT/examples/asr && \
             python speech_to_text_finetune.py \
               --config-path /workspace/configs \
               --config-name an4_finetune \
               init_from_pretrained_model=$PRETRAINED_MODEL \
               trainer.max_epochs=$MAX_EPOCHS \
               exp_manager.exp_dir=/workspace/outputs"

echo "=== Done. Checkpoints in $REPO_ROOT/outputs/ ==="
