# Agent Prompt: Weekly Experiment Check

Use this prompt when an agent has a SplitLaunch API key and the user wants a
plain-language performance summary.

```text
Run a weekly SplitLaunch experiment check.

Use SPLITLAUNCH_API_KEY from the environment and the live skills page at
https://www.splitlaunch.dev/api/skills.

Steps:

1. List projects and ask which project to inspect if more than one exists.
2. List running experiments for the selected project.
3. For each running experiment, pull reports.experiment.details for the primary
   goal and reports.experiment.channels for channel context.
4. Pull reports.experiment.chart with interval day if traffic looks uneven.
5. Pull usage.summary for the current month.
6. Summarize each experiment with visitors, exposures, conversions, conversion
   rate, revenue if present, absolute difference, relative lift, and caveats.
7. Label each test as keep running, ready to decide, needs investigation, or
   candidate for follow-up.
8. Do not pause or end anything unless I explicitly approve it.
```
