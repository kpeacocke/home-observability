# Phase 1 - Visibility Foundation

## Objective

Build baseline visibility for home/lab reliability and user experience across network, DNS, hosts, containers, and mDNS repeater.

## Outcomes

- Single-pane operational visibility in Grafana
- Centralized logs in OpenSearch
- Core alerting with low-noise defaults
- 90-day retention baseline

## Scope

- DrayTek syslog to Vector
- SNMP telemetry from DrayTek + Synology
- Pi-hole metrics and DNS health probes
- NAS host + container metrics
- mDNS repeater log focus stream

## Deliverables

- Dashboards: Home Overview, DNS Health, Network Health, mDNS Health
- Alert rules: WAN, DNS, storage, restart storms
- AWX templates: deploy, validate, rollback, evidence collection
- Baseline runbooks for incident triage

## Exit Criteria

- All data sources visible and queryable
- End-to-end alert path verified
- Deployment fully reproducible via Ansible
