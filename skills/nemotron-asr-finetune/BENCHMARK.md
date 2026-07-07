# Evaluation Report

Evaluation of the `nemotron-asr-finetune` skill before publication through NVSkills-Eval.

This benchmark summarizes the intended 3-Tier Evaluation for the skill. The goal is to document whether the skill is safe, discoverable, effective, and useful for agents before it is published for broader workflow use. Populate the results tables from an actual NVSkills-Eval run before publication.

## Evaluation Summary

- Skill: `nemotron-asr-finetune`
- Evaluation date: TBD
- NVSkills-Eval profile: `external`
- Environment: `local`
- Dataset: 9 evaluation tasks (`evals/evals.json`)
- Attempts per task: 2
- Pass threshold: 50%
- Overall verdict: TBD

## Agents Used

- `claude-code`
- `codex`

## Metrics Used

Reported benchmark dimensions:

- Security: checks whether skill-assisted execution avoids unsafe behavior such as secret leakage (HF/NGC tokens), recommending unnecessarily expensive GPU training over a cheaper runtime option, or training on validation/test transcripts.
- Correctness: checks whether the agent scopes the task, recommends the cheapest sufficient path, and delegates each stage to the right sub-skill.
- Discoverability: checks whether the agent loads the skill for ASR customization/orchestration work and avoids it for pure deployment, OpenAI Whisper, or text-LLM tasks.
- Effectiveness: checks whether the agent performs measurably better with the skill than without it.
- Efficiency: checks whether the agent uses fewer tokens and avoids redundant work by loading only the relevant reference file.

Underlying evaluation signals:

- `skill_execution`: verifies the agent loaded the expected skill and stage reference.
- `skill_efficiency`: checks routing quality, decoy avoidance, and redundant tool usage.
- `accuracy`: grades final-answer correctness against the reference answer.
- `goal_accuracy`: checks whether the overall user task completed successfully.
- `behavior_check`: verifies expected behavior steps, including safety expectations.
- `token_efficiency`: compares token usage with and without the skill.

## Test Tasks

The benchmark dataset contains 9 evaluation tasks:

- Positive tasks: 6 tasks where the skill is expected to activate (scope the goal, choose the cheapest path, escalate to fine-tuning, map sub-skills, cost/time/data planning, evaluate + loop/ship).
- Negative tasks: 3 tasks where no skill is expected (pure export/deployment of an existing model, OpenAI Whisper fine-tuning, text-LLM fine-tuning).

Entries with `expected_skill` set are positive skill-activation cases; entries with `expected_skill: null` are negative activation cases.

## Results

| Dimension | Num | `claude-code` | `codex` |
|---|---:|---:|---:|
| Security | TBD | TBD | TBD |
| Correctness | TBD | TBD | TBD |
| Discoverability | TBD | TBD | TBD |
| Effectiveness | TBD | TBD | TBD |
| Efficiency | TBD | TBD | TBD |

Score values show skill-assisted performance. Values in parentheses show uplift versus the no-skill baseline when baseline data is available.

## Tier 1: Static Validation Summary

Run NVSkills-Eval Tier 1 static validation against `SKILL.md` and the reference files, and record findings here. Expected checks include description WHEN-to-use coverage, reference-file naming/nesting, and script documentation.

## Tier 2: Deduplication Summary

Run NVSkills-Eval Tier 2 deduplication (context and inter-skill) and record findings. Note the intended split: this is an **orchestration** skill that scopes the task, picks the cheapest sufficient path, and delegates to sub-skills — `nemo-speech-asr-finetune` (training and evaluation), `data-designer` (synthetic text data), and `nemotron-speech` (export/serving/runtime customization). It should not duplicate those sub-skills' content, only route to them.

## Publication Recommendation

Populate the results above from a real NVSkills-Eval run, then state whether the skill is suitable to proceed toward publication. Keep this file with the skill and refresh it when the evaluation dataset, skill behavior, or target agents materially change.
