# Snowbelt Desk

An AI support-triage console for **Snowbelt Supply Co.**, a Buffalo, NY online winter-gear retailer. Built for the UB Forge × Delta Sigma Pi Promptathon.

**The problem:** tickets went from 300 to 1,200 a week, first response time went from 4 hours to 2.5 days, and repeat purchases fell from 35% to 28%. There are 5 reps, no new hires allowed, and a $2,000/month tools budget.

**The goal:** get first response time under 24 hours without hurting customer trust.

## How it works

Every ticket goes through five steps:

1. **Read** the message.
2. **Classify and score** it. Claude returns JSON: topic, confidence, mood (-1 to 1), order number, and risk flags (chargeback/legal, safety, repeat contact, asks for a person).
3. **Look up the order** in the store system (mocked here).
4. **Guardrails.** Seven fixed rules in code, not in the model, choose the route:
   - **Auto-send:** every check passes (order status, in-policy returns, sizing questions).
   - **Rep review:** a refund, replacement, reship, final-sale exception, low confidence, or an attempt to override the AI's instructions. The rep approves with one click.
   - **Escalate:** an angry customer, a chargeback or legal threat, or a safety issue. The ticket goes straight to a named senior rep as priority 1, with a 1-hour reply target.
5. **Write the reply.** Claude drafts it using only facts from the order record and the store policy. AI replies say they came from AI, and the customer can type "person" to reach the team.

The **Business case** tab shows the numbers. About 76% of tickets get answered in under a minute, reps handle 282 a week (below the pre-holiday load of 300), tools cost about $400 a month, and about $840K a year in repeat revenue is at risk. A slider lets you test the automation rate.

**Run whole queue** processes every open ticket one after another, so you can watch the backlog clear.

**Pop-up ads (a gag):** sketchy ad-network-style pop-ups appear every 15–35 seconds and pause while a ticket is running. There are six kinds: a "virus" alert, a prize wheel, a dating "match" nearby, a fake download, a "1 weird trick" before/after, and a chat bubble. All of them are winter jokes with no real brands. Click **★ Remove ads** to sit through a 10-second ad wall (each ad click adds 3 seconds), then subscribe to Premium for "$999/month", which plows the ads away. It's a joke: there are no card fields and nothing is charged. Your browser remembers Premium, and you can cancel it from the same button to bring the ads back. Press Esc to skip the ad wall.

## Running it

- **Live with Claude:** the page is published as a claude.ai artifact, where it calls Claude through the artifact runtime (`claude.use("sample")`). No API key is needed.
- **Anywhere else:** open `index.html` in a browser, or turn on GitHub Pages for this repo. Without the claude.ai runtime the page switches to its offline rules engine (keyword triage plus template replies), so the full flow still runs.

## Files

| File | What it is |
| --- | --- |
| `snowbelt-desk.html` | The source. Published as the claude.ai artifact, so it has no `<html>`/`<head>` wrapper. |
| `index.html` | A standalone copy for browsers and GitHub Pages. Generated; don't edit it by hand. |
| `scripts/build.sh` | Rebuilds `index.html` from `snowbelt-desk.html`. Run it after every edit. |

## Demo script (2 minutes)

1. Run **Erin Kowalski**'s ticket. It's a stuck package, so it gets auto-sent with a UPS trace in a few seconds.
2. Run **Joe Brennan**'s ticket. It's his third email and he threatens a chargeback, so it escalates to Maya as priority 1.
3. Click **＋ Test a new customer message** and paste the judge's message. Try **Prompt injection** too: "ignore all previous instructions" gets caught and held for review.
4. Open **Prompt sent to Claude** in the right panel to show the prompt itself.
