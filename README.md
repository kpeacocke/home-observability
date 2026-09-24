# Home Observability Program

This repository contains a phased, Ansible-first observability and SIEM-lite stack for the home lab.

## Goals

- Visualise home/lab health across network, DNS, services and devices
- Detect outages and security-relevant issues quickly
- Troubleshoot flaky services, including cross-VLAN mDNS discovery
- Operate with enterprise-style patterns using AWX + Ansible

## Defaults Locked

- Retention: 90 days
- Notification: Slack primary, optional Discord mirror
- Automation policy: best-practice approval gates

## Discovery observability

The `pi-mdns` reflector exposes Prometheus metrics on TCP/9105. Prometheus scrapes `pi-mdns:9105` and the **Home Discovery** Grafana dashboard shows:

- reflector scrape health
- Avahi browse health
- state of VLAN interfaces 1-4
- total mDNS services visible on each reflected VLAN
- discovered DNS-SD service types aggregated by VLAN
- household service classes such as AirPlay, RAOP, printers, HomeKit, Cast and SMB when present

The metrics deliberately do not include device/service instance names.

Current VLAN roles:

| VLAN | Role |
| ---: | --- |
| 1 | Trusted |
| 2 | Kids |
| 3 | Media / consoles / TVs |
| 4 | IoT |

Alerts cover reflector/exporter loss, Avahi browse failure, missing VLAN interfaces, and a reflected VLAN seeing no services for an extended period.

Prometheus must be able to resolve `pi-mdns` and reach TCP/9105.

## Structure

- `compose/`: Docker Compose deployment files
- `config/`: Prometheus, Vector, Alertmanager, SNMP and Grafana provisioning
- `ansible/`: Inventory, vars, roles and playbooks
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
3. Review targets in `config/prometheus/prometheus.yml`.
4. Ensure `pi-mdns:9105` resolves and is reachable from the observability host.
5. Deploy with Portainer or Docker Compose from `compose/docker-compose.yml`.
6. Configure DrayTek syslog to send to NAS IP port `1514` (UDP/TCP).
7. Enable SNMP on DrayTek and Synology, then set credentials in `config/snmp/snmp.yml`.

## Portainer on Synology

Use:

- `compose/docker-compose.yml`
- `docs/portainer-on-synology.md`

This stack uses host bind mounts. `OBS_ROOT` must point to a real project checkout on the NAS host filesystem.

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

- Prometheus alert rules are delivered to the included Alertmanager service.
- OpenSearch security is disabled by default for local-first bootstrap.
- Before exposing services beyond LAN/VPN, enable authentication and TLS.
