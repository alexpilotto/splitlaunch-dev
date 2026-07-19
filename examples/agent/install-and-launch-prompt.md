# Agent Prompt: Install And Launch A First Experiment

Use this prompt in a coding agent after the user has created a SplitLaunch
account and provided an API key in a safe environment variable.

```text
Install SplitLaunch in this repository.

Use SPLITLAUNCH_API_KEY from the environment. Run:

npm install @splitlaunch/ab
npx splitlaunch init

Then:

1. Inspect the app structure and add the SplitLaunch pixel snippet in the safest
   global browser location for this framework.
2. Add a conversion event called Lead after the existing lead/demo form submits
   successfully.
3. Use https://www.splitlaunch.dev/api/skills as the command reference.
4. Create or verify the Lead goal through the command API.
5. Ask me for the control URL and variation URL before creating the experiment.
6. Add the required domains with domains.add.
7. Create the experiment as a draft.
8. Do not set status to running until I explicitly approve launch.
9. After each write, read back the relevant resource and summarize what changed
   in plain language.
```
