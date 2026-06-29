# Program Charter

## Mission

Visualize and improve the lived home network experience while building enterprise-aligned observability and incident-response practices.

## Success Metrics

- Critical outage detection under 2 minutes
- Likely root-cause identification under 10 minutes
- False positive ratio under 20% after tuning
- 100% changes through Ansible + AWX

## Change Governance

- Auto-execution: diagnostics and evidence collection only
- Single approval: service restart and safe remediations
- Dual approval: firewall, routing, and DNS policy changes

## Retention

- Metrics: 90 days
- Logs: 90 days baseline, optional shorter retention for very noisy classes
