# Home Observability Program

This repository contains a phased, Ansible-first observability and SIEM-lite stack for a home lab.

## Goals

- Visualize home/lab health (network, DNS, services, devices)
- Detect outages and security-relevant issues quickly
- Troubleshoot flaky services (including mDNS repeater)
- Operate with enterprise-style patterns using AWX + Ansible

## Defaults Locked

- Retention: 90 days
- Notification: Slack primary, optional Discord mirror
- Automation policy: best-practice approval gates

## Structure

- `compose/`: Docker Compose deployment files
- `config/`: Prometheus, Vector, Alertmanager, SNMP, Grafana provisioning
- `ansible/`: Inventory, vars, roles, playbooks
- `docs/phases/`: Phase-by-phase execution plans
- `docs/awx/`: AWX templates and workflow definitions

## Quick Start

1. Copy `compose/.env.example` to `compose/.env` and fill values.
2. Required env vars in `compose/.env`:
	- `OBS_ROOT` (absolute NAS path to this repo)
	- `GRAFANA_ADMIN_USER`
	- `GRAFANA_ADMIN_PASSWORD`
	- `PIHOLE1_HOST`
	- `PIHOLE1_PASSWORD`
	- `PIHOLE2_HOST`
	- `PIHOLE2_PASSWORD`
3. Review and update IPs/targets in `config/prometheus/prometheus.yml`.
4. Deploy with Portainer or Docker Compose from `compose/docker-compose.yml`.
5. Configure DrayTek syslog to send to NAS IP port `1514` (UDP/TCP).
6. Enable SNMP on DrayTek and Synology, then set credentials in `config/snmp/snmp.yml`.

## Portainer on Synology (Best Path)

Use the same compose file and the deployment guide:

- `compose/docker-compose.yml`
- `docs/portainer-on-synology.md`

Note: this stack uses host bind mounts. `OBS_ROOT` must point to a real project checkout on the NAS host filesystem.

## Run with Compose

```bash
cd compose
cp .env.example .env
# edit .env
docker compose up -d
```

## Run with Ansible

```bash
cd ansible
ansible-playbook -i inventory/hosts.yml deploy.yml
```

## Notes

- OpenSearch security plugin is disabled by default for local-first bootstrap.
- Before exposing services beyond LAN/VPN, enable authentication and TLS.
