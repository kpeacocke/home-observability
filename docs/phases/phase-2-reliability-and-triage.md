# Phase 2 - Reliability and Incident Triage

## Objective

Reduce MTTD and MTTR with synthetic checks, incident timelines, and repeatable triage workflows.

## Outcomes

- Fast fault-domain identification (WAN vs DNS vs service vs host)
- Repeatable incident evidence workflow
- mDNS repeater troubleshooting playbook with correlation views

## Scope

- Add synthetic checks for internet reachability and DNS resolution
- Add timeline dashboard correlating alerts, logs, and restarts
- Add mDNS repeater-specific SLO-like indicators

## Deliverables

- Incident Timeline dashboard
- mDNS repeater debug panel set
- Evidence bundle AWX job
- Triage runbook for top 8 incidents

## Exit Criteria

- First responder can classify primary fault domain in less than 10 minutes
- mDNS instability incidents are diagnosable with evidence, not guesswork
