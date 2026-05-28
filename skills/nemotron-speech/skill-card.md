## Description: <br>
Use for any NVIDIA Nemotron Speech (formerly Riva) NIM task — deploy, run, or test ASR (speech-to-text), TTS (text-to-speech), or NMT (translation) speech NIMs, cloud-hosted via build.nvidia.com or self-hosted on your own GPU. <br>

This skill is ready for commercial/non-commercial use. <br>

## Owner
NVIDIA <br>

### License/Terms of Use: <br>
CC-BY-4.0 AND Apache 2.0 <br>
## Use Case: <br>
Developers and engineers deploying, running, or testing NVIDIA Nemotron Speech (Riva) ASR, TTS, and NMT NIMs using AI coding assistants. <br>

### Deployment Geography for Use: <br>
Global <br>

## Known Risks and Mitigations: <br>
Risk: Review before execution as proposals could introduce incorrect or misleading guidance into skills. <br>
Mitigation: Review and scan skill before deployment. <br>

## Reference(s): <br>
- [Environment Setup](references/setup.md) <br>
- [ASR Deployment and Inference](references/asr.md) <br>
- [ASR Custom Model Deployment](references/asr-custom.md) <br>
- [TTS Deployment and Inference](references/tts.md) <br>
- [NMT Deployment and Inference](references/nmt.md) <br>
- [ASR Pipeline Configuration](references/pipelines.md) <br>
- [Model Selection](references/model-selection.md) <br>
- [Deployment Readiness Checks](references/deployment-readiness-checks.md) <br>
- [ASR Support Matrix](https://docs.nvidia.com/nim/speech/latest/reference/support-matrix/asr.html) <br>
- [TTS Support Matrix](https://docs.nvidia.com/nim/speech/latest/reference/support-matrix/tts.html) <br>
- [NMT Support Matrix](https://docs.nvidia.com/nim/speech/latest/reference/support-matrix/nmt.html) <br>


## Skill Output: <br>
**Output Type(s):** [Shell commands, Configuration instructions, Code] <br>
**Output Format:** [Markdown with inline bash code blocks] <br>
**Output Parameters:** [1D] <br>
**Other Properties Related to Output:** [None] <br>

## Evaluation Agents Used: <br>
- Claude Code (`claude-code`) <br>
- Codex (`codex`) <br>



## Evaluation Tasks: <br>
Evaluated against 12 evaluation tasks (9 positive skill-activation, 3 negative) using NVSkills-Eval external profile with 2 attempts per task at 50% pass threshold. <br>

## Evaluation Metrics Used: <br>
Reported benchmark dimensions: <br>
- Security: Checks whether skill-assisted execution avoids unsafe behavior such as secret leakage, destructive commands, or unauthorized access. <br>
- Correctness: Checks whether the agent follows the expected workflow and produces the correct final output. <br>
- Discoverability: Checks whether the agent loads the skill when relevant and avoids using it when irrelevant. <br>
- Effectiveness: Checks whether the agent performs measurably better with the skill than without it. <br>
- Efficiency: Checks whether the agent uses fewer tokens and avoids redundant work. <br>

Underlying evaluation signals used in this run: <br>
- `skill_execution`: Verifies that the agent loaded the expected skill and workflow. <br>
- `skill_efficiency`: Checks routing quality, decoy avoidance, and redundant tool usage. <br>
- `accuracy`: Grades final-answer correctness against the reference answer. <br>
- `goal_accuracy`: Checks whether the overall user task completed successfully. <br>
- `behavior_check`: Verifies expected behavior steps, including safety expectations. <br>
- `token_efficiency`: Compares token usage with and without the skill. <br>



## Evaluation Results: <br>
| Dimension | Num | `claude-code` | `codex` |
|---|---:|---:|---:|
| Security | 8 | 79% (+15%) | 76% (-1%) |
| Correctness | 8 | 86% (+6%) | 80% (+2%) |
| Discoverability | 8 | 88% (+26%) | 63% (+1%) |
| Effectiveness | 8 | 85% (+9%) | 73% (-1%) |
| Efficiency | 8 | 85% (+35%) | 53% (-1%) |

## Skill Version(s): <br>
1.0.0 (source: frontmatter) <br>

## Ethical Considerations: <br>
NVIDIA believes Trustworthy AI is a shared responsibility and we have established policies and practices to enable development for a wide array of AI applications. When downloaded or used in accordance with our terms of service, developers should work with their internal team to ensure this skill meets requirements for the relevant industry and use case and addresses unforeseen product misuse. <br>

(For Release on NVIDIA Platforms Only) <br>
Please report quality, risk, security vulnerabilities or NVIDIA AI Concerns [here](https://app.intigriti.com/programs/nvidia/nvidiavdp/detail). <br>
