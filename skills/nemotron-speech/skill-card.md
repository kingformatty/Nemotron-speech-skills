## Description: <br>
Use for any NVIDIA Nemotron Speech (formerly Riva) NIM task — deploy, run, or test ASR (speech-to-text), TTS (text-to-speech), or NMT (translation) speech NIMs, cloud-hosted (build.nvidia.com) or self-hosted on your own GPU. <br>

This skill is ready for commercial/non-commercial use. <br>

## Owner: NVIDIA <br>

### License/Terms of Use: <br>
CC-BY-4.0 AND Apache 2.0 <br>
## Use Case: <br>
Developers and integrators deploying or testing NVIDIA Nemotron Speech (Riva) Speech NIMs — automatic speech recognition (ASR), text-to-speech (TTS), or neural machine translation (NMT) — via build.nvidia.com cloud inference or self-hosted Docker deployment. Also covers custom NeMo checkpoint conversion to Riva NIMs via riva-build / riva-deploy, advanced ASR pipeline tuning (VAD, diarization, language models), and pre-deployment hardware compatibility checks. <br>

### Deployment Geography for Use: <br>
Global <br>

## Known Risks and Mitigations: <br>
Risk: Review before execution as proposals could introduce incorrect or misleading guidance into skills. <br>
Mitigation: Review and scan skill before deployment. <br>

## Reference(s): <br>
- [asr.md — Deploy and run Riva ASR NIMs](references/asr.md) <br>
- [asr-custom.md — Convert a NeMo checkpoint into a custom Riva ASR NIM](references/asr-custom.md) <br>
- [tts.md — Deploy and run Riva TTS NIMs](references/tts.md) <br>
- [nmt.md — Deploy and run Riva NMT NIMs](references/nmt.md) <br>
- [pipelines.md — ASR pipeline tuning (VAD, diarization, language models)](references/pipelines.md) <br>
- [model-selection.md — Choose the right ASR/TTS/NMT model](references/model-selection.md) <br>
- [setup.md — Environment setup (drivers, Docker, NGC)](references/setup.md) <br>
- [deployment-readiness-checks.md — Hardware compatibility and health checks](references/deployment-readiness-checks.md) <br>
- [NVIDIA Speech NIM Documentation](https://docs.nvidia.com/nim/speech/latest/) <br>
- [ASR Support Matrix](https://docs.nvidia.com/nim/speech/latest/reference/support-matrix/asr.html) <br>
- [TTS Support Matrix](https://docs.nvidia.com/nim/speech/latest/reference/support-matrix/tts.html) <br>
- [NMT Support Matrix](https://docs.nvidia.com/nim/speech/latest/reference/support-matrix/nmt.html) <br>
- [build.nvidia.com (cloud inference)](https://build.nvidia.com) <br>
- [NGC Catalog (NIM containers)](https://catalog.ngc.nvidia.com/orgs/nim/teams/nvidia/models) <br>


## Skill Output: <br>
**Output Type(s):** [Shell commands, Configuration instructions, Analysis] <br>
**Output Format:** [Markdown with inline bash, Python, and YAML code blocks] <br>
**Output Parameters:** [1D] <br>
**Other Properties Related to Output:** [Commands are presented to the user for review; the skill does not auto-execute. Cloud calls use NVIDIA_API_KEY; self-hosted runs use NGC_API_KEY and require an NVIDIA AI Enterprise entitlement.] <br>

## Skill Version(s): <br>
1.0.0 (source: frontmatter) <br>

## Ethical Considerations: <br>
NVIDIA believes Trustworthy AI is a shared responsibility and we have established policies and practices to enable development for a wide array of AI applications. When downloaded or used in accordance with our terms of service, developers should work with their internal team to ensure this skill meets requirements for the relevant industry and use case and addresses unforeseen product misuse. <br>

(For Release on NVIDIA Platforms Only) <br>
Please report quality, risk, security vulnerabilities or NVIDIA AI Concerns [here](https://app.intigriti.com/programs/nvidia/nvidiavdp/detail). <br>
