## Description: <br>
Orchestration skill for NVIDIA Nemotron Speech (Riva) / NeMo ASR domain and language adaptation. Given a goal like "fine-tune ASR for my domain/language", it scopes the task, picks the cheapest sufficient path (word boosting → n-gram LM → fine-tuning), delegates each stage to the right sub-skill (data generation, training, evaluation, deployment), and answers cost/time/data questions along the way. <br>

This skill is ready for commercial/non-commercial use. <br>

## Owner
NVIDIA <br>

### License/Terms of Use: <br>
CC-BY-4.0 AND Apache 2.0 <br>
## Use Case: <br>
Developers and engineers adapting NVIDIA Nemotron Speech (Riva) ASR to a domain or language using AI coding assistants. This high-level orchestration skill scopes the task, chooses the cheapest sufficient customization path, and sequences the right sub-skills — data generation (data-designer), training and evaluation (nemo-speech-asr-finetune), and deployment (nemotron-speech) — while answering cost/time/data questions. Sub-skills own execution; this skill owns the plan and routing. <br>

### Deployment Geography for Use: <br>
Global <br>

## Known Risks and Mitigations: <br>
Risk: Review before execution as proposals could introduce incorrect guidance, recommend unnecessarily expensive GPU training when a cheaper path would suffice, or route to a sub-skill that is only a placeholder. <br>
Mitigation: Review and scan the skill before deployment; the orchestration favors the cheapest sufficient path, requires scoping and a measured baseline before escalating, and names placeholder sub-skills explicitly with interim guidance. <br>

## Reference(s): <br>
- [Orchestration Workflow](references/workflow.md) <br>
- [Sub-Skill Registry](references/sub-skills.md) <br>
- [Path Selection (cheapest sufficient rung)](references/path-selection.md) <br>
- [Cost / Time / Data Planning Answers](references/planning-answers.md) <br>
- [Orchestration Plan Template](assets/experiment-ledger-template.md) <br>
- [NVIDIA NeMo](https://github.com/NVIDIA/NeMo) <br>
- [NIM Speech ASR Customization Guide](https://docs.nvidia.com/nim/speech/latest/asr/customization/customization.html) <br>
- [NIM Speech Documentation](https://docs.nvidia.com/nim/speech/latest/index.html) <br>

## Skill Output: <br>
**Output Type(s):** [Scoped plans, path recommendations, sub-skill routing, cost/time/data estimates] <br>
**Output Format:** [Markdown with inline bash/python code blocks] <br>
**Output Parameters:** [1D] <br>
**Other Properties Related to Output:** [None] <br>

## Evaluation Agents Used: <br>
- Claude Code (`claude-code`) <br>
- Codex (`codex`) <br>

## Evaluation Tasks: <br>
9 evaluation tasks (6 positive activation, 3 negative activation) with 2 attempts per task at 50% pass threshold. <br>

## Evaluation Metrics Used: <br>
Reported benchmark dimensions: <br>
- Security: Checks whether skill-assisted execution avoids unsafe behavior such as token/key leakage, destructive commands, or training on validation/test transcripts. <br>
- Correctness: Checks whether the agent scopes the task, recommends the cheapest sufficient path, and delegates each stage to the right sub-skill. <br>
- Discoverability: Checks whether the agent loads the skill when relevant and avoids it for deployment, OpenAI Whisper, or text-LLM tasks. <br>
- Effectiveness: Checks whether the agent performs measurably better with the skill than without it. <br>
- Efficiency: Checks whether the agent uses fewer tokens and avoids redundant work. <br>

Underlying evaluation signals used in this run: <br>
- `skill_execution`: Verifies that the agent loaded the expected skill and stage reference. <br>
- `skill_efficiency`: Checks routing quality, decoy avoidance, and redundant tool usage. <br>
- `accuracy`: Grades final-answer correctness against the reference answer. <br>
- `goal_accuracy`: Checks whether the overall user task completed successfully. <br>
- `behavior_check`: Verifies expected behavior steps, including safety expectations. <br>
- `token_efficiency`: Compares token usage with and without the skill. <br>

## Evaluation Results: <br>
| Dimension | Num | `claude-code` | `codex` |
|---|---:|---:|---:|
| Security | TBD | TBD | TBD |
| Correctness | TBD | TBD | TBD |
| Discoverability | TBD | TBD | TBD |
| Effectiveness | TBD | TBD | TBD |
| Efficiency | TBD | TBD | TBD |

## Skill Version(s): <br>
1.0.0 (source: frontmatter) <br>

## Ethical Considerations: <br>
NVIDIA believes Trustworthy AI is a shared responsibility and we have established policies and practices to enable development for a wide array of AI applications. When downloaded or used in accordance with our terms of service, developers should work with their internal team to ensure this skill meets requirements for the relevant industry and use case and addresses unforeseen product misuse. <br>

(For Release on NVIDIA Platforms Only) <br>
Please report quality, risk, security vulnerabilities or NVIDIA AI Concerns [here](https://app.intigriti.com/programs/nvidia/nvidiavdp/detail). <br>
