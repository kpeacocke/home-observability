# AWX Templates and Workflows

## Job Templates

1. Deploy Observability Stack
- Playbook: `ansible/deploy.yml`
- Purpose: initial deployment and idempotent updates

2. Validate Stack Health
- Playbook: `ansible/deploy.yml` with tags (future split)
- Purpose: verify endpoint and pipeline health

3. Rollback Stack
- Purpose: rollback to previous compose/config version

4. Collect Incident Evidence
- Purpose: package logs, alerts, and key metrics snapshots

5. Backup Config and Data Policies
- Purpose: preserve config artifacts and lifecycle settings

## Workflow Template

- Node 1: Deploy Stack
- Node 2: Validate Health
- On success: Notify success channel
- On failure: Rollback Stack
- Post-rollback: Notify critical channel and attach logs

## Approval Gates

- Required before disruptive actions
- Required before policy changes to DNS/firewall/routing

## Notifications

- Slack default channel for warnings
- Slack critical channel for sev-critical
- Optional Discord mirror for selected alerts
