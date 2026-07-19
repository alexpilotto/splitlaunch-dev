# SplitLaunch Examples

These examples show how developers and AI agents can call SplitLaunch from
shell scripts or use agent prompts inside coding tools.

## cURL Examples

- [Create a project](curl/create-project.sh)
- [Launch an experiment draft](curl/launch-experiment.sh)
- [Pull an experiment report](curl/pull-report.sh)
- [Set up tracking](curl/setup-tracking.sh)

## Agent Prompt Examples

- [Install and launch prompt](agent/install-and-launch-prompt.md)
- [Weekly check prompt](agent/weekly-check-prompt.md)

## Environment Variables

The shell examples expect environment variables such as:

```bash
export SPLITLAUNCH_API_KEY='sl_live_REPLACE_WITH_REAL_KEY'
export SPLITLAUNCH_PROJECT_ID='PROJECT_ID'
export SPLITLAUNCH_EXPERIMENT_ID='EXPERIMENT_ID'
```

Do not commit real API keys to GitHub.
