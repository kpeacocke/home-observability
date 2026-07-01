# Run on Synology via Portainer (Recommended)

This is the simplest reliable approach for Synology + Portainer.

Important: this stack uses host bind mounts for config files. That means Docker must be able to read files from `OBS_ROOT` on the NAS host filesystem.

## Recommended Deployment Pattern

Use a Git-backed Portainer stack with `compose/docker-compose.yml` and set stack environment variables in Portainer.

Portainer's internal repository checkout is not the same as host bind mount paths. The compose file mounts from `OBS_ROOT`, so the repo must also exist on the NAS host at that path.

Why this is the best path:

- Easy upgrades (`pull latest` + redeploy)
- Clear config ownership in Git
- No fragile relative path assumptions
- Works with your existing Portainer workflow

## 1. Prepare NAS paths

Create a shared folder path on Synology:

- `/volume1/docker/home-observability`

Clone or copy this repository there on the NAS host, ensuring `config/` exists under that path.

Example on NAS shell:

```bash
mkdir -p /volume1/docker
cd /volume1/docker
git clone <your-repo-url> home-observability
```

If you do not want to use Git on NAS, copy the project files there with your normal file sync workflow.

## 2. Configure Portainer Stack

In Portainer:

1. `Stacks` -> `Add stack`
2. `Repository` method (Git)
3. Repository URL: your repo URL
4. Compose path: `compose/docker-compose.yml`
5. Set these environment variables:

- `OBS_ROOT=/volume1/docker/home-observability`
- `GRAFANA_ADMIN_USER=admin`
- `GRAFANA_ADMIN_PASSWORD=<strong password>`
- `PIHOLE1_HOST=http://<primary-pihole-ip>`
- `PIHOLE1_PASSWORD=<primary-pihole-password>`
- `PIHOLE2_HOST=http://<secondary-pihole-ip>`
- `PIHOLE2_PASSWORD=<secondary-pihole-password>`
- `CADVISOR_HOST_PORT=18080` (optional, change if needed)

Note: the repository method in Portainer only provides the compose content. Runtime config mounts still come from `OBS_ROOT` on the host.

## 3. Post-deploy wiring

1. DrayTek syslog target -> NAS IP port `1514` UDP/TCP
2. Enable SNMP read-only on DrayTek and Synology
3. Update SNMP community in `config/snmp/snmp.yml`
4. Update Prometheus targets in `config/prometheus/prometheus.yml`
5. Update webhooks in `config/alertmanager/alertmanager.yml`

## 4. Validate

- Grafana: `http://<nas-ip>:3000`
- Prometheus: `http://<nas-ip>:9090`
- OpenSearch Dashboards: `http://<nas-ip>:5601`

## 5. Upgrade model

- Commit config change to Git
- In Portainer stack: `Pull and redeploy`
- Verify dashboard and alert health

## Synology caveats

- `cadvisor` may need adjustment depending on your Synology Docker runtime paths.
- If deployment fails with `port is already allocated` for cAdvisor, set a different `CADVISOR_HOST_PORT` in Portainer (for example `18081`).
- If `cadvisor` fails, keep stack running and temporarily remove that service while retaining node metrics + SNMP + logs.
- Keep this stack LAN-only or behind VPN/reverse proxy with auth.

## Security minimums

- Replace all placeholder secrets before deployment.
- Do not expose OpenSearch directly to WAN.
- Enable TLS/auth before any remote access.
