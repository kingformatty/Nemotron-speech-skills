# Evaluation Report

Evaluation of the `nemotron-speech` skill before publication through NVSkills-Eval.

This benchmark summarizes 3-Tier Evaluation from NVSkills-Eval results for the skill. The goal is to document whether the skill is safe, discoverable, effective, and useful for agents before it is published for broader workflow use.

## Evaluation Summary

- Skill: `nemotron-speech`
- Evaluation date: 2026-05-28
- NVSkills-Eval profile: `external`
- Environment: `local`
- Dataset: 12 evaluation tasks
- Attempts per task: 2
- Pass threshold: 50%
- Overall verdict: FAIL

## Agents Used

- `claude-code`
- `codex`

## Metrics Used

Reported benchmark dimensions:

- Security: checks whether skill-assisted execution avoids unsafe behavior such as secret leakage, destructive commands, or unauthorized access.
- Correctness: checks whether the agent follows the expected workflow and produces the correct final output.
- Discoverability: checks whether the agent loads the skill when relevant and avoids using it when irrelevant.
- Effectiveness: checks whether the agent performs measurably better with the skill than without it.
- Efficiency: checks whether the agent uses fewer tokens and avoids redundant work.

Underlying evaluation signals used in this run:

- `skill_execution` (Skill Execution): verifies that the agent loaded the expected skill and workflow.
- `skill_efficiency` (Efficiency): checks routing quality, decoy avoidance, and redundant tool usage.
- `accuracy` (Accuracy): grades final-answer correctness against the reference answer.
- `goal_accuracy` (Goal Accuracy): checks whether the overall user task completed successfully.
- `behavior_check` (Behavior Check): verifies expected behavior steps, including safety expectations.
- `token_efficiency` (Token Efficiency): compares token usage with and without the skill.

## Test Tasks

The benchmark dataset contained 12 evaluation tasks:

- Positive tasks: 9 tasks where the skill was expected to activate.
- Negative tasks: 3 tasks where no skill was expected.
- Unlabeled tasks: 0 tasks where positive/negative intent could not be inferred.

Task composition is derived from the evaluation dataset when possible. Entries with `expected_skill` set are treated as positive skill-activation cases, while entries with `expected_skill: null` are treated as negative activation cases.

## Results

| Dimension | Num | `claude-code` | `codex` |
|---|---:|---:|---:|
| Security | 8 | 79% (+15%) | 76% (-1%) |
| Correctness | 8 | 86% (+6%) | 80% (+2%) |
| Discoverability | 8 | 88% (+26%) | 63% (+1%) |
| Effectiveness | 8 | 85% (+9%) | 73% (-1%) |
| Efficiency | 8 | 85% (+35%) | 53% (-1%) |

Score values show skill-assisted performance. Values in parentheses show uplift versus the no-skill baseline when baseline data is available.

## Tier 1: Static Validation Summary

Tier 1 validation passed with observations. NVSkills-Eval ran 9 checks and found 9 total findings.

Top findings:

- MEDIUM QUALITY/quality_correctness: No documented scripts in table format (`skills/nemotron-speech/SKILL.md`)
- MEDIUM QUALITY/quality_correctness: Instructions don't mention 'run_script' (`skills/nemotron-speech/SKILL.md`)
- MEDIUM QUALITY/quality_discoverability: Description uses first/second person (`skills/nemotron-speech/SKILL.md`)
- MEDIUM QUALITY/quality_efficiency: Deeply nested references in pipelines.md (`skills/nemotron-speech/SKILL.md`)
- LOW QUALITY/quality_discoverability: Description very long (990 chars, recommend 50-150) (`skills/nemotron-speech/SKILL.md`)

## Tier 2: Deduplication Summary

Tier 2 validation reported findings. NVSkills-Eval ran 2 checks and found 3 total findings.

Top findings:

- HIGH DUPLICATE/duplicate: Duplicate content found across references/asr-custom.md and references/asr.md:
  "# Note: chown to UID 1000:1000 because the NIM container runs as nvs:1000 inside" in references/asr-custom.md (lines 84-84)
  vs "# Note: chown to UID 1000:1000 because the NIM container runs as nvs:1000 inside" in references/asr.md (lines 154-154) (`references/asr-custom.md:84`)
- HIGH DUPLICATE/duplicate: Duplicate content found across SKILL.md and references/deployment-readiness-checks.md and references/nmt.md and references/setup.md and references/tts.md:
  "## Next Steps" in SKILL.md (lines 90-95)
  vs "## Next Steps" in references/deployment-readiness-checks.md (lines 185-189)
  vs "## Next Steps" in references/nmt.md (lines 319-322)
  vs "## Next Steps" in references/setup.md (lines 176-182)
  vs "## Next Steps" in references/tts.md (lines 393-396) (`SKILL.md:90`)
- HIGH DUPLICATE/duplicate: Duplicate content found within references/asr-custom.md:
  "## Phase 3 — Deploy Model Repository with `riva-deploy`" in references/asr-custom.md (lines 152-158)
  vs "# Force overwrite" in references/asr-custom.md (lines 159-182) (`references/asr-custom.md:152`)

## Publication Recommendation

The skill should be reviewed before NVSkills-Eval publication. Skill owners should address the findings above and rerun NVSkills-Eval to refresh this benchmark.
