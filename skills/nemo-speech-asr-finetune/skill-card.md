## Description
Execution sub-skill for NeMo ASR fine-tuning on any NVIDIA GPU. Given a prepared dataset and a pretrained model name, it handles environment verification, manifest creation, Docker-based NeMo training launch, and checkpoint saving. Designed to be invoked by the `nemotron-asr-finetune` orchestration skill when fine-tuning is the chosen path.

This skill is ready for commercial/non-commercial use.

## Owner
NVIDIA

### License/Terms of Use
Apache-2.0

## Use Case
Engineers running NeMo ASR fine-tuning on local NVIDIA hardware (any Ampere/Hopper/GB GPU). Accepts a dataset path, pretrained model name, and epoch count; produces `.nemo` checkpoints and TensorBoard logs. Validated on DGX Spark (GB10) with `nvcr.io/nvidia/nemo:25.04`.

### Deployment Geography for Use
Global

## Known Risks and Mitigations
Risk: Generated Docker commands and training configs are starting points — review before production use.
Mitigation: Skill verifies GPU visibility and Docker image presence before launching. OOM guidance provided for both unified-memory (Spark) and discrete GPU setups.

## Reference(s)
- [NVIDIA NeMo](https://github.com/NVIDIA/NeMo)
- [NeMo ASR Fine-tuning Docs](https://docs.nvidia.com/deeplearning/nemo/user-guide/docs/en/stable/asr/configs.html)
- [NIM Speech ASR Customization Guide](https://docs.nvidia.com/nim/speech/latest/asr/customization/customization.html)

## Skill Output
**Output Type(s):** Training checkpoints (`.nemo`, `.ckpt`), TensorBoard logs
**Output Format:** Files under `outputs/`
**Output Parameters:** Pretrained model, dataset, epochs, precision

## Evaluation Results
Argument passthrough tests (validated 2026-07-12 on DGX Spark GB10, NeMo 25.04):
- `max_epochs` override: PASSED — trainer stopped at correct epoch
- Custom dataset path: PASSED — path resolved and mounted correctly
- Alternative model (`stt_en_conformer_ctc_medium`): PASSED — 1 epoch trained successfully
- Full run (`stt_en_conformer_ctc_small`, 10 epochs, AN4): best val WER **0.26%**

## Skill Version
0.1.0
